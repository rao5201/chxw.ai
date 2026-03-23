import { supabase, supabaseAdmin } from './supabase-client.js'

const ADMIN_KEY = process.env.ADMIN_KEY || 'chxw2026'

function isAdmin(req) {
  const auth = req.headers.authorization || ''
  return auth === ADMIN_KEY || auth === `Bearer ${ADMIN_KEY}`
}

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*')
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,OPTIONS')
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization')
}

export default async function handler(req, res) {
  cors(res)

  if (req.method === 'OPTIONS') {
    return res.status(200).end()
  }

  try {
    // POST - 提交联系表单 / 邮件订阅 (公开)
    if (req.method === 'POST') {
      const { name, email, message, type } = req.body

      if (!email) {
        return res.status(400).json({ success: false, error: '邮箱为必填项' })
      }

      // 简单邮箱格式校验
      if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
        return res.status(400).json({ success: false, error: '请输入有效的邮箱地址' })
      }

      const contactType = type || (message ? 'contact' : 'newsletter')

      // 对 newsletter 类型去重
      if (contactType === 'newsletter') {
        const { data: existing } = await supabase
          .from('contacts')
          .select('id')
          .eq('email', email)
          .eq('type', 'newsletter')
          .limit(1)

        if (existing && existing.length > 0) {
          return res.status(200).json({ success: true, data: null, message: '该邮箱已订阅' })
        }
      }

      const { data, error } = await supabase
        .from('contacts')
        .insert([{ name: name || null, email, message: message || null, type: contactType }])
        .select()

      if (error) throw error
      return res.status(201).json({ success: true, data: data[0], message: contactType === 'newsletter' ? '订阅成功' : '消息已发送' })
    }

    // GET - 获取所有联系记录 (管理员)
    if (req.method === 'GET') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { type, unread } = req.query || {}

      let query = supabaseAdmin
        .from('contacts')
        .select('*')
        .order('created_at', { ascending: false })

      if (type) {
        query = query.eq('type', type)
      }

      if (unread === 'true') {
        query = query.eq('is_read', false)
      }

      const { data, error } = await query

      if (error) throw error
      return res.status(200).json({ success: true, data })
    }

    // PUT - 标记为已读 (管理员)
    if (req.method === 'PUT') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { id, ids } = req.body

      if (!id && !ids) {
        return res.status(400).json({ success: false, error: '缺少联系记录ID' })
      }

      // 支持批量标记
      if (ids && Array.isArray(ids)) {
        const { data, error } = await supabaseAdmin
          .from('contacts')
          .update({ is_read: true })
          .in('id', ids)
          .select()

        if (error) throw error
        return res.status(200).json({ success: true, data })
      }

      const { data, error } = await supabaseAdmin
        .from('contacts')
        .update({ is_read: true })
        .eq('id', id)
        .select()

      if (error) throw error
      return res.status(200).json({ success: true, data: data[0] })
    }

    return res.status(405).json({ success: false, error: '不支持的请求方法' })
  } catch (err) {
    console.error('Contacts API Error:', err)
    return res.status(500).json({ success: false, error: err.message || '服务器内部错误' })
  }
}

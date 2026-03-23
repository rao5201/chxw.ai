import { supabase, supabaseAdmin } from './supabase-client.js'

const ADMIN_KEY = process.env.ADMIN_KEY || 'chxw2026'

function isAdmin(req) {
  const auth = req.headers.authorization || ''
  return auth === ADMIN_KEY || auth === `Bearer ${ADMIN_KEY}`
}

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*')
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS')
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization')
}

export default async function handler(req, res) {
  cors(res)

  if (req.method === 'OPTIONS') {
    return res.status(200).end()
  }

  try {
    // GET - 获取所有活跃项目
    if (req.method === 'GET') {
      const { data, error } = await supabase
        .from('projects')
        .select('*')
        .eq('is_active', true)
        .order('sort_order', { ascending: true })

      if (error) throw error
      return res.status(200).json({ success: true, data })
    }

    // POST - 添加新项目 (管理员)
    if (req.method === 'POST') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { name, category, mrr, growth, description, tags, icon, link, action_text, sort_order } = req.body

      if (!name || !category) {
        return res.status(400).json({ success: false, error: '名称和类别为必填项' })
      }

      const { data, error } = await supabaseAdmin
        .from('projects')
        .insert([{ name, category, mrr, growth, description, tags, icon, link, action_text, sort_order }])
        .select()

      if (error) throw error
      return res.status(201).json({ success: true, data: data[0] })
    }

    // PUT - 更新项目 (管理员)
    if (req.method === 'PUT') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { id, ...updates } = req.body

      if (!id) {
        return res.status(400).json({ success: false, error: '缺少项目ID' })
      }

      const { data, error } = await supabaseAdmin
        .from('projects')
        .update(updates)
        .eq('id', id)
        .select()

      if (error) throw error
      return res.status(200).json({ success: true, data: data[0] })
    }

    // DELETE - 软删除项目 (管理员)
    if (req.method === 'DELETE') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { id } = req.body || req.query

      if (!id) {
        return res.status(400).json({ success: false, error: '缺少项目ID' })
      }

      const { data, error } = await supabaseAdmin
        .from('projects')
        .update({ is_active: false })
        .eq('id', id)
        .select()

      if (error) throw error
      return res.status(200).json({ success: true, data: data[0] })
    }

    return res.status(405).json({ success: false, error: '不支持的请求方法' })
  } catch (err) {
    console.error('Projects API Error:', err)
    return res.status(500).json({ success: false, error: err.message || '服务器内部错误' })
  }
}

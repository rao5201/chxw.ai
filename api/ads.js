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
    // GET - 获取所有活跃广告
    if (req.method === 'GET') {
      const { platform } = req.query || {}

      let query = supabase
        .from('ads')
        .select('*')
        .eq('is_active', true)
        .order('created_at', { ascending: false })

      if (platform) {
        query = query.eq('platform', platform)
      }

      const { data, error } = await query

      if (error) throw error
      return res.status(200).json({ success: true, data })
    }

    // POST - 添加新广告 (管理员)
    if (req.method === 'POST') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { platform, title, likes, shares, days_running, thumbnail, original_link, final_landing, video_url } = req.body

      if (!platform || !title) {
        return res.status(400).json({ success: false, error: '平台和标题为必填项' })
      }

      const { data, error } = await supabaseAdmin
        .from('ads')
        .insert([{ platform, title, likes, shares, days_running, thumbnail, original_link, final_landing, video_url }])
        .select()

      if (error) throw error
      return res.status(201).json({ success: true, data: data[0] })
    }

    // PUT - 更新广告 (管理员)
    if (req.method === 'PUT') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { id, ...updates } = req.body

      if (!id) {
        return res.status(400).json({ success: false, error: '缺少广告ID' })
      }

      const { data, error } = await supabaseAdmin
        .from('ads')
        .update(updates)
        .eq('id', id)
        .select()

      if (error) throw error
      return res.status(200).json({ success: true, data: data[0] })
    }

    // DELETE - 软删除广告 (管理员)
    if (req.method === 'DELETE') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { id } = req.body || req.query

      if (!id) {
        return res.status(400).json({ success: false, error: '缺少广告ID' })
      }

      const { data, error } = await supabaseAdmin
        .from('ads')
        .update({ is_active: false })
        .eq('id', id)
        .select()

      if (error) throw error
      return res.status(200).json({ success: true, data: data[0] })
    }

    return res.status(405).json({ success: false, error: '不支持的请求方法' })
  } catch (err) {
    console.error('Ads API Error:', err)
    return res.status(500).json({ success: false, error: err.message || '服务器内部错误' })
  }
}

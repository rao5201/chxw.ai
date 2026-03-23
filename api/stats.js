import { supabase, supabaseAdmin } from './supabase-client.js'

const ADMIN_KEY = process.env.ADMIN_KEY || 'chxw2026'

function isAdmin(req) {
  const auth = req.headers.authorization || ''
  return auth === ADMIN_KEY || auth === `Bearer ${ADMIN_KEY}`
}

function cors(res) {
  res.setHeader('Access-Control-Allow-Origin', '*')
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,OPTIONS')
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type,Authorization')
}

export default async function handler(req, res) {
  cors(res)

  if (req.method === 'OPTIONS') {
    return res.status(200).end()
  }

  try {
    // POST - 增加今日访客计数 (公开)
    if (req.method === 'POST') {
      const today = new Date().toISOString().slice(0, 10)

      // 尝试更新今日记录
      const { data: existing } = await supabase
        .from('visitor_stats')
        .select('id, page_views, unique_visitors')
        .eq('date', today)
        .limit(1)

      if (existing && existing.length > 0) {
        const row = existing[0]
        const { data, error } = await supabase
          .from('visitor_stats')
          .update({
            page_views: row.page_views + 1,
            unique_visitors: row.unique_visitors + (req.body?.is_new ? 1 : 0)
          })
          .eq('id', row.id)
          .select()

        if (error) throw error
        return res.status(200).json({ success: true, data: data[0] })
      }

      // 今日无记录，插入新行
      const { data, error } = await supabase
        .from('visitor_stats')
        .insert([{
          date: today,
          page_views: 1,
          unique_visitors: 1
        }])
        .select()

      if (error) throw error
      return res.status(201).json({ success: true, data: data[0] })
    }

    // GET - 获取访客统计 (管理员)
    if (req.method === 'GET') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { days } = req.query || {}
      const limit = parseInt(days) || 30

      const { data, error } = await supabaseAdmin
        .from('visitor_stats')
        .select('*')
        .order('date', { ascending: false })
        .limit(limit)

      if (error) throw error

      // 计算汇总
      const totalViews = data.reduce((sum, r) => sum + (r.page_views || 0), 0)
      const totalVisitors = data.reduce((sum, r) => sum + (r.unique_visitors || 0), 0)

      return res.status(200).json({
        success: true,
        data: {
          daily: data,
          summary: {
            total_page_views: totalViews,
            total_unique_visitors: totalVisitors,
            days_tracked: data.length
          }
        }
      })
    }

    return res.status(405).json({ success: false, error: '不支持的请求方法' })
  } catch (err) {
    console.error('Stats API Error:', err)
    return res.status(500).json({ success: false, error: err.message || '服务器内部错误' })
  }
}

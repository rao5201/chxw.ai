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
    // GET - 获取所有广告位
    if (req.method === 'GET') {
      const { data, error } = await supabase
        .from('ad_slots')
        .select('*')
        .order('slot_number', { ascending: true })

      if (error) throw error
      return res.status(200).json({ success: true, data })
    }

    // POST - 创建新广告位 (管理员)
    if (req.method === 'POST') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { slot_number, status, advertiser_name, advertiser_link, advertiser_logo, price_monthly, contact_email, start_date, end_date } = req.body

      if (!slot_number) {
        return res.status(400).json({ success: false, error: '广告位编号为必填项' })
      }

      const { data, error } = await supabaseAdmin
        .from('ad_slots')
        .insert([{ slot_number, status, advertiser_name, advertiser_link, advertiser_logo, price_monthly, contact_email, start_date, end_date }])
        .select()

      if (error) throw error
      return res.status(201).json({ success: true, data: data[0] })
    }

    // PUT - 更新广告位状态 (管理员)
    if (req.method === 'PUT') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { id, slot_number, ...updates } = req.body
      const filterField = id ? 'id' : 'slot_number'
      const filterValue = id || slot_number

      if (!filterValue) {
        return res.status(400).json({ success: false, error: '缺少广告位ID或编号' })
      }

      const { data, error } = await supabaseAdmin
        .from('ad_slots')
        .update(updates)
        .eq(filterField, filterValue)
        .select()

      if (error) throw error
      return res.status(200).json({ success: true, data: data[0] })
    }

    // DELETE - 清空广告位 (重置为可用状态，管理员)
    if (req.method === 'DELETE') {
      if (!isAdmin(req)) {
        return res.status(401).json({ success: false, error: '未授权访问' })
      }

      const { id, slot_number } = req.body || req.query
      const filterField = id ? 'id' : 'slot_number'
      const filterValue = id || slot_number

      if (!filterValue) {
        return res.status(400).json({ success: false, error: '缺少广告位ID或编号' })
      }

      const { data, error } = await supabaseAdmin
        .from('ad_slots')
        .update({
          status: 'available',
          advertiser_name: null,
          advertiser_link: null,
          advertiser_logo: null,
          contact_email: null,
          start_date: null,
          end_date: null
        })
        .eq(filterField, filterValue)
        .select()

      if (error) throw error
      return res.status(200).json({ success: true, data: data[0] })
    }

    return res.status(405).json({ success: false, error: '不支持的请求方法' })
  } catch (err) {
    console.error('Ad Slots API Error:', err)
    return res.status(500).json({ success: false, error: err.message || '服务器内部错误' })
  }
}

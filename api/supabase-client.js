import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.SUPABASE_URL || 'YOUR_SUPABASE_URL'
const supabaseAnonKey = process.env.SUPABASE_ANON_KEY || 'YOUR_SUPABASE_ANON_KEY'
const supabaseServiceKey = process.env.SUPABASE_SERVICE_KEY || ''

// 公开客户端 (受 RLS 限制)
export const supabase = createClient(supabaseUrl, supabaseAnonKey)

// 管理员客户端 (绕过 RLS，仅在服务端使用)
export const supabaseAdmin = supabaseServiceKey
  ? createClient(supabaseUrl, supabaseServiceKey)
  : supabase

-- 茶海虾王 数据库架构
-- Supabase PostgreSQL

-- 启用UUID扩展
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. 项目表 (AI高收益项目)
CREATE TABLE projects (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL,
  mrr VARCHAR(50),
  growth VARCHAR(20),
  description TEXT,
  tags TEXT[] DEFAULT '{}',
  icon VARCHAR(50) DEFAULT 'fa-rocket',
  link VARCHAR(500),
  action_text VARCHAR(50) DEFAULT '访问官网',
  is_active BOOLEAN DEFAULT true,
  sort_order INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 广告创意表
CREATE TABLE ads (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  platform VARCHAR(20) NOT NULL CHECK (platform IN ('TikTok', 'Facebook', 'Instagram', 'Google')),
  title VARCHAR(200) NOT NULL,
  likes VARCHAR(20),
  shares VARCHAR(20),
  days_running INT DEFAULT 0,
  thumbnail VARCHAR(500),
  original_link VARCHAR(500),
  final_landing VARCHAR(500),
  video_url VARCHAR(500),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. 联盟计划表
CREATE TABLE affiliates (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  commission VARCHAR(50),
  cookie_period VARCHAR(30),
  assets VARCHAR(100),
  link VARCHAR(500),
  is_active BOOLEAN DEFAULT true,
  sort_order INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. 广告位表
CREATE TABLE ad_slots (
  id SERIAL PRIMARY KEY,
  slot_number INT UNIQUE NOT NULL CHECK (slot_number BETWEEN 1 AND 12),
  status VARCHAR(20) DEFAULT 'available' CHECK (status IN ('available', 'taken', 'reserved')),
  advertiser_name VARCHAR(100),
  advertiser_link VARCHAR(500),
  advertiser_logo VARCHAR(500),
  price_monthly DECIMAL(10,2),
  contact_email VARCHAR(200),
  start_date DATE,
  end_date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. 联系/咨询表
CREATE TABLE contacts (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(200) NOT NULL,
  message TEXT,
  type VARCHAR(20) DEFAULT 'contact' CHECK (type IN ('contact', 'newsletter', 'ad_inquiry')),
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 6. 访客统计表
CREATE TABLE visitor_stats (
  id SERIAL PRIMARY KEY,
  date DATE UNIQUE DEFAULT CURRENT_DATE,
  page_views INT DEFAULT 0,
  unique_visitors INT DEFAULT 0
);

-- 7. 网站设置表
CREATE TABLE site_settings (
  key VARCHAR(50) PRIMARY KEY,
  value TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 索引
CREATE INDEX idx_projects_active ON projects(is_active, sort_order);
CREATE INDEX idx_projects_category ON projects(category) WHERE is_active = true;
CREATE INDEX idx_ads_platform ON ads(platform) WHERE is_active = true;
CREATE INDEX idx_contacts_type ON contacts(type, is_read);
CREATE INDEX idx_visitor_date ON visitor_stats(date);

-- 自动更新 updated_at 触发器
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER projects_updated_at BEFORE UPDATE ON projects FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Row Level Security (RLS) policies
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE ads ENABLE ROW LEVEL SECURITY;
ALTER TABLE affiliates ENABLE ROW LEVEL SECURITY;
ALTER TABLE ad_slots ENABLE ROW LEVEL SECURITY;
ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE visitor_stats ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;

-- 公开读取策略 (所有人可读 active 数据)
CREATE POLICY "Public read projects" ON projects FOR SELECT USING (is_active = true);
CREATE POLICY "Public read ads" ON ads FOR SELECT USING (is_active = true);
CREATE POLICY "Public read affiliates" ON affiliates FOR SELECT USING (is_active = true);
CREATE POLICY "Public read ad_slots" ON ad_slots FOR SELECT USING (true);
CREATE POLICY "Public read settings" ON site_settings FOR SELECT USING (true);

-- 公开写入联系表
CREATE POLICY "Public insert contacts" ON contacts FOR INSERT WITH CHECK (true);

-- 公开更新访客统计
CREATE POLICY "Public update visitor_stats" ON visitor_stats FOR ALL USING (true) WITH CHECK (true);

-- 管理员完全访问 (通过 service_role key)
-- Supabase service_role key 自动绕过 RLS

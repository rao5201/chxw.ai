茶海虾王 - 数据库配置指南
========================

一、创建 Supabase 项目
1. 访问 https://supabase.com 注册（免费）
2. 创建新项目，选择区域
3. 记录: Project URL 和 anon public key

二、初始化数据库
1. 进入 Supabase Dashboard > SQL Editor
2. 运行 database/schema.sql 创建表结构
3. 运行 database/seed.sql 填充初始数据

三、环境变量配置
在 Vercel 项目设置中添加:
- SUPABASE_URL = your-project.supabase.co
- SUPABASE_ANON_KEY = your-anon-key
- SUPABASE_SERVICE_KEY = your-service-role-key (用于管理后台)
- ADMIN_KEY = chxw2026

四、部署到 Vercel
1. 安装 Vercel CLI: npm i -g vercel
2. 在项目根目录运行: vercel
3. 按提示绑定 GitHub 仓库
4. 添加环境变量后重新部署

五、自定义域名
1. 在 Vercel 项目设置中添加域名
2. 在域名DNS中添加 CNAME 记录指向 cname.vercel-dns.com

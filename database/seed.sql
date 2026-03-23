-- 茶海虾王 初始数据填充
-- 请在 schema.sql 执行完毕后运行此脚本

-- ============================================
-- 1. 项目数据 (12个AI高收益项目)
-- ============================================
INSERT INTO projects (name, category, mrr, growth, description, tags, icon, link, action_text, sort_order) VALUES
('WriteGenius AI', 'SaaS', '$125,000+', '32', '基于GPT-4o的SEO内容生产引擎，支持50+语言自动生成高排名文章，已帮助2000+品牌提升自然流量。', ARRAY['SaaS','SEO','内容营销'], 'fa-solid fa-pen-nib', 'https://writegenius.ai', '立即体验', 1),
('FaceSwap Pro', 'API', '$89,000+', '45', '毫秒级人脸替换API，支持视频/图片批量处理，广泛用于短视频创作和电商素材制作。', ARRAY['API','视频','TikTok'], 'fa-solid fa-face-smile', 'https://faceswappro.com', '获取API', 2),
('CodeFix Bot', 'Plugin', '$45,000+', '28', 'VS Code智能修复插件，自动检测Bug并生成修复方案，覆盖Python/JS/Go等20+语言。', ARRAY['Plugin','开发者','效率'], 'fa-solid fa-bug-slash', 'https://codefix.dev', '安装插件', 3),
('VoiceClone Studio', 'App', '$210,000+', '67', 'TikTok爆款声音克隆工具，3秒复制任意人声，支持实时变声和多平台直播。', ARRAY['APP','TikTok','语音'], 'fa-solid fa-microphone-lines', 'https://voiceclone.studio', '开始克隆', 4),
('DataViz AI', 'SaaS', '$67,000+', '22', 'Excel一键生成专业数据看板，支持拖拽编辑和自动洞察，让数据分析零门槛。', ARRAY['SaaS','数据','效率'], 'fa-solid fa-chart-pie', 'https://dataviz.ai', '免费试用', 5),
('LegalMind Assistant', 'Enterprise', '$150,000+', '38', 'AI合同审阅助手，秒级扫描法律风险条款，已服务Fortune 500企业法务部门。', ARRAY['Enterprise','法律','B2B'], 'fa-solid fa-scale-balanced', 'https://legalmind.ai', '预约演示', 6),
('AdCopy AI', 'SaaS', '$78,000+', '35', 'Facebook/Google广告文案自动生成器，内置A/B测试模板和行业最佳实践，提升广告转化率40%。', ARRAY['SaaS','广告','营销'], 'fa-solid fa-bullhorn', 'https://adcopy.ai', '生成文案', 7),
('ResumeBot Pro', 'App', '$55,000+', '41', 'AI简历生成器，根据职位JD智能匹配关键词，支持一键生成多版本简历和求职信。', ARRAY['APP','求职','效率'], 'fa-solid fa-file-lines', 'https://resumebot.pro', '制作简历', 8),
('PhotoEnhance AI', 'API', '$92,000+', '29', '图片超分辨率API，支持4K/8K无损放大，广泛应用于电商产品图和房产照片增强。', ARRAY['API','图片','电商'], 'fa-solid fa-image', 'https://photoenhance.ai', '获取API', 9),
('ChatBot Builder', 'SaaS', '$115,000+', '48', '零代码智能客服搭建平台，支持多语言和全渠道部署，平均降低客服成本60%。', ARRAY['SaaS','客服','零代码'], 'fa-solid fa-robot', 'https://chatbotbuilder.io', '免费创建', 10),
('SEO Pilot', 'SaaS', '$83,000+', '26', '全自动SEO优化平台，智能分析竞品、生成优化方案并监控排名变化，一站式SEO解决方案。', ARRAY['SaaS','SEO','营销'], 'fa-solid fa-compass', 'https://seopilot.io', '开始优化', 11),
('TubeScript AI', 'App', '$71,000+', '53', 'YouTube视频脚本AI生成器，分析热门视频结构并生成高留存率脚本，适合内容创作者。', ARRAY['APP','YouTube','内容营销'], 'fa-brands fa-youtube', 'https://tubescript.ai', '写脚本', 12);

-- ============================================
-- 2. 广告创意数据 (6条广告)
-- ============================================
INSERT INTO ads (platform, title, likes, shares, days_running, thumbnail, original_link, final_landing) VALUES
('TikTok', 'AI换脸神器 - 3秒变明星脸', '128K', '32K', 45, 'https://placehold.co/400x300/1e293b/3b82f6?text=AI+FaceSwap', 'https://tiktok.com/@faceswappro', 'https://faceswappro.com/lp-tiktok-v3'),
('Facebook', 'AI写作工具让你的博客流量翻10倍', '85K', '18K', 62, 'https://placehold.co/400x300/1e293b/8b5cf6?text=AI+Writer', 'https://facebook.com/ads/writegenius', 'https://writegenius.ai/lp-fb-seo'),
('TikTok', '这个AI工具让我月入$50K', '256K', '67K', 30, 'https://placehold.co/400x300/1e293b/ec4899?text=AI+Income', 'https://tiktok.com/@voiceclone', 'https://voiceclone.studio/lp-income'),
('Facebook', '律师都在用的AI合同审核工具', '42K', '9K', 88, 'https://placehold.co/400x300/1e293b/22c55e?text=AI+Legal', 'https://facebook.com/ads/legalmind', 'https://legalmind.ai/lp-lawyer'),
('TikTok', '用AI做电商图片 - 销量暴增300%', '189K', '45K', 21, 'https://placehold.co/400x300/1e293b/f59e0b?text=AI+Photo', 'https://tiktok.com/@photoenhance', 'https://photoenhance.ai/lp-ecommerce'),
('Facebook', '零代码搭建AI客服 - 节省60%人力成本', '63K', '14K', 55, 'https://placehold.co/400x300/1e293b/06b6d4?text=AI+ChatBot', 'https://facebook.com/ads/chatbotbuilder', 'https://chatbotbuilder.io/lp-save-cost');

-- ============================================
-- 3. 联盟计划数据 (8个联盟)
-- ============================================
INSERT INTO affiliates (name, commission, cookie_period, assets, link, sort_order) VALUES
('Jasper AI', '30% 终身循环佣金', '90天', 'Banner + 邮件模板 + 视频素材', 'https://jasper.ai/partners', 1),
('Midjourney', '20% 首年佣金', '60天', '创意图片包 + 社媒文案', 'https://midjourney.com/affiliate', 2),
('Notion AI', '50% 首月 + 15% 循环', '120天', '教程视频 + 对比表格', 'https://notion.so/affiliates', 3),
('Synthesia', '25% 循环佣金', '90天', '演示视频 + PPT模板', 'https://synthesia.io/partners', 4),
('Copy.ai', '45% 首月佣金', '60天', 'Landing Page模板 + 邮件序列', 'https://copy.ai/affiliates', 5),
('Descript', '15% 终身循环佣金', '30天', '视频教程 + 社媒素材包', 'https://descript.com/affiliates', 6),
('Runway ML', '20% 首年佣金', '45天', '创意素材包 + 案例研究', 'https://runway.ml/partners', 7),
('ElevenLabs', '22% 终身循环佣金', '60天', '语音Demo + 推广脚本', 'https://elevenlabs.io/affiliates', 8);

-- ============================================
-- 4. 广告位数据 (12个席位，#3和#8已售)
-- ============================================
INSERT INTO ad_slots (slot_number, status, advertiser_name, contact_email) VALUES
(1, 'available', NULL, NULL),
(2, 'available', NULL, NULL),
(3, 'taken', 'AI Write Pro', 'writepro@ai.com'),
(4, 'available', NULL, NULL),
(5, 'available', NULL, NULL),
(6, 'available', NULL, NULL),
(7, 'available', NULL, NULL),
(8, 'taken', 'VideoGen AI', 'biz@videogen.ai'),
(9, 'available', NULL, NULL),
(10, 'available', NULL, NULL),
(11, 'available', NULL, NULL),
(12, 'available', NULL, NULL);

-- ============================================
-- 5. 网站设置
-- ============================================
INSERT INTO site_settings (key, value) VALUES
('site_name', '茶海虾王'),
('admin_password', 'chxw2026'),
('contact_email', 'rao5201@126.com'),
('site_description', 'AI商业机会快速连接平台'),
('newsletter_enabled', 'true');

-- ============================================
-- 6. 初始访客统计
-- ============================================
INSERT INTO visitor_stats (date, page_views, unique_visitors) VALUES
(CURRENT_DATE, 0, 0);

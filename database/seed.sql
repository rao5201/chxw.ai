-- 茶海虾王 初始数据填充 (2026年5月更新版)
-- 请在 schema.sql 执行完毕后运行此脚本

-- ============================================
-- 1. 项目数据 (12个AI高收益项目 - 2025/2026)
-- ============================================
INSERT INTO projects (name, category, mrr, growth, description, tags, icon, link, action_text, sort_order) VALUES
('Cursor', 'SaaS', '$180,000', '55', '基于AI的下一代代码编辑器，集成GPT-4o与Claude，支持代码补全、重构和自然语言编程，程序员效率提升10倍。', ARRAY['IDE','开发者','效率'], 'fa-solid fa-code', 'https://cursor.com', '立即体验', 1),
('Perplexity AI', 'SaaS', '$350,000', '42', 'AI驱动的答案引擎，取代传统搜索引擎，实时联网检索+AI总结，用户已超1亿。', ARRAY['搜索','AI助手'], 'fa-solid fa-magnifying-glass', 'https://perplexity.ai', '立即体验', 2),
('Midjourney v7', 'App', '$520,000', '18', 'AI图像生成领域王者，v7版本支持视频生成和3D建模，设计师和创作者必备神器。', ARRAY['图像','创意'], 'fa-solid fa-palette', 'https://midjourney.com', '开始创作', 3),
('ElevenLabs', 'API', '$280,000', '63', '全球领先的AI语音平台，支持声音克隆、多语言TTS、实时配音，广泛用于内容创作和影视后期。', ARRAY['语音','TTS'], 'fa-solid fa-microphone', 'https://elevenlabs.io', '获取API', 4),
('Gamma', 'SaaS', '$95,000', '71', 'AI演示文稿生成器，一句话生成精美PPT，支持实时协作和自定义模板，告别枯燥设计。', ARRAY['演示','效率'], 'fa-solid fa-presentation-screen', 'https://gamma.app', '免费试用', 5),
('Lovable', 'SaaS', '$160,000', '88', 'AI全栈应用构建器，用自然语言描述需求即可生成完整Web应用，零代码创业神器。', ARRAY['零代码','全栈'], 'fa-solid fa-heart', 'https://lovable.dev', '开始构建', 6),
('Bolt.new', 'SaaS', '$140,000', '76', 'StackBlitz推出的AI Web开发工具，浏览器内直接编码部署，支持全栈框架一键生成。', ARRAY['Web开发','在线IDE'], 'fa-solid fa-bolt', 'https://bolt.new', '立即体验', 7),
('Suno AI', 'App', '$210,000', '45', 'AI音乐生成平台，输入文字即可创作完整歌曲，支持多风格和人声，TikTok爆款音乐神器。', ARRAY['音乐','创作'], 'fa-solid fa-music', 'https://suno.com', '开始创作', 8),
('HeyGen', 'API', '$320,000', '52', 'AI数字人视频平台，上传照片即可生成逼真虚拟主播视频，支持100+语言和多平台投放。', ARRAY['数字人','视频'], 'fa-solid fa-video', 'https://heygen.com', '制作视频', 9),
('Replit Agent', 'SaaS', '$120,000', '67', 'AI编程代理，用自然语言描述需求，自动生成、调试和部署完整应用，编程小白也能做产品。', ARRAY['Agent','编程'], 'fa-solid fa-terminal', 'https://replit.com', '开始使用', 10),
('Devin AI', 'Enterprise', '$250,000', '93', '全球首个自主AI软件工程师，可独立完成需求分析、编码、测试和部署，企业级编程新范式。', ARRAY['AI工程师','B2B'], 'fa-solid fa-robot', 'https://devin.ai', '预约演示', 11),
('NotebookLM', 'App', '$0', '200', 'Google推出的AI研究助手，上传文档自动生成播客、摘要和问答，学生和研究者的效率倍增器。', ARRAY['研究','播客'], 'fa-solid fa-book-open', 'https://notebooklm.google', '免费使用', 12);

-- ============================================
-- 2. 广告创意数据 (6条广告 - 2026更新)
-- ============================================
INSERT INTO ads (platform, title, likes, shares, days_running, thumbnail, original_link, final_landing) VALUES
('TikTok', '程序员效率提升10倍 - Cursor AI', '89K', '23K', 38, 'https://placehold.co/400x220/0c1529/00e5a0?text=Cursor+AI', 'https://tiktok.com/@cursor', 'https://cursor.com/lp-tiktok'),
('YouTube', 'Google替代品来了 - Perplexity搜索革命', '125K', '34K', 52, 'https://placehold.co/400x220/0c1529/a855f7?text=Perplexity', 'https://youtube.com/@perplexity', 'https://perplexity.ai/lp-yt'),
('TikTok', '用AI复制任何人的声音 - ElevenLabs', '234K', '67K', 25, 'https://placehold.co/400x220/0c1529/ec4899?text=ElevenLabs', 'https://tiktok.com/@elevenlabs', 'https://elevenlabs.io/lp-clone'),
('Facebook', 'PPT自动生成 - Gamma AI演示', '42K', '11K', 44, 'https://placehold.co/400x220/0c1529/22c55e?text=Gamma+PPT', 'https://facebook.com/ads/gamma', 'https://gamma.app/lp-fb'),
('TikTok', '不写代码也能做APP - Lovable全栈开发', '112K', '29K', 18, 'https://placehold.co/400x220/0c1529/00a8ff?text=Lovable', 'https://tiktok.com/@lovable', 'https://lovable.dev/lp-tiktok'),
('TikTok', 'AI作曲30秒出歌 - Suno音乐创作', '178K', '45K', 33, 'https://placehold.co/400x220/0c1529/f59e0b?text=Suno+AI', 'https://tiktok.com/@sunoai', 'https://suno.com/lp-music');

-- ============================================
-- 3. 联盟计划数据 (8个联盟 - 2026更新)
-- ============================================
INSERT INTO affiliates (name, commission, cookie_period, assets, link, sort_order) VALUES
('Cursor Pro', '25% 循环佣金', '60天', 'Banner + 教程视频 + 代码Demo', 'https://cursor.com/affiliates', 1),
('Perplexity Pro', '20% 循环佣金', '90天', '对比图表 + 邮件模板 + 社媒文案', 'https://perplexity.ai/affiliates', 2),
('Midjourney', '15% 首年佣金', '45天', '创意图片包 + 社媒文案', 'https://midjourney.com/affiliate', 3),
('ElevenLabs', '22% 终身循环佣金', '60天', '语音Demo + 推广脚本 + 视频素材', 'https://elevenlabs.io/affiliates', 4),
('Gamma Pro', '30% 前3月佣金', '90天', 'PPT模板 + 教程视频 + 对比表格', 'https://gamma.app/affiliates', 5),
('HeyGen', '20% 循环佣金', '60天', '演示视频 + Landing Page模板', 'https://heygen.com/affiliates', 6),
('Suno Pro', '25% 首年佣金', '30天', '音乐Demo + 创作教程 + 邮件序列', 'https://suno.com/affiliates', 7),
('Jasper AI', '30% 终身循环佣金', '90天', 'Banner + 邮件模板 + 视频素材', 'https://jasper.ai/partners', 8);

-- ============================================
-- 4. 广告位数据 (12个席位)
-- ============================================
INSERT INTO ad_slots (slot_number, status, advertiser_name, contact_email) VALUES
(1, 'available', NULL, NULL),
(2, 'available', NULL, NULL),
(3, 'available', NULL, NULL),
(4, 'available', NULL, NULL),
(5, 'available', NULL, NULL),
(6, 'available', NULL, NULL),
(7, 'available', NULL, NULL),
(8, 'available', NULL, NULL),
(9, 'available', NULL, NULL),
(10, 'available', NULL, NULL),
(11, 'available', NULL, NULL),
(12, 'available', NULL, NULL);

-- ============================================
-- 5. 网站设置
-- ============================================
INSERT INTO site_settings (key, value) VALUES
('site_name', '茶海虾王'),
('contact_email', 'rao5201@126.com'),
('site_description', 'AI商业机会快速连接平台'),
('newsletter_enabled', 'true'),
('data_updated_at', '2026-05-10');

-- ============================================
-- 6. 初始访客统计
-- ============================================
INSERT INTO visitor_stats (date, page_views, unique_visitors) VALUES
(CURRENT_DATE, 0, 0);

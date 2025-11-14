#!/bin/bash

# 🔥 一键提交脚本 - 最简版本
# Table Column Resizer 插件提交助手

echo "🎯 一键提交助手启动！"
echo "==================="
echo ""

# 1. 显示需要复制的内容
echo "📋 第一步：复制插件配置"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cat plugin-submission.json
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 2. 显示PR描述
echo "📤 第二步：复制PR描述"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
head -20 pr-description.md
echo "...（完整内容在pr-description.md中）"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 3. 打开浏览器
echo "🌐 正在打开GitHub页面..."

# 尝试不同的打开方式
if command -v open &> /dev/null; then
    open "https://github.com/obsidianmd/obsidian-releases"
elif command -v xdg-open &> /dev/null; then
    xdg-open "https://github.com/obsidianmd/obsidian-releases"
elif command -v start &> /dev/null; then
    start "https://github.com/obsidianmd/obsidian-releases"
else
    echo "请手动访问：https://github.com/obsidianmd/obsidian-releases"
fi

echo ""
echo "🎯 超简单3步操作："
echo "1️⃣ 点击右上角 'Fork' 按钮"
echo "2️⃣ 找到 community-plugins.json 文件，点击 ✏️ 编辑"
echo "3️⃣ 粘贴上面的JSON内容，提交后创建PR"
echo ""
echo "📄 详细步骤请参考：UPDATED_GITHUB_GUIDE.md"
echo ""
echo "⏰ 预计时间：3-5分钟"
echo "🎉 加油！马上完成！"
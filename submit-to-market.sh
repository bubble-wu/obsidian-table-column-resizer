#!/bin/bash

# Obsidian插件市场提交脚本
# 作者：bubble
# 日期：$(date)

echo "🚀 开始提交Table Column Resizer插件到Obsidian市场..."

# 检查必要的文件是否存在
echo "📋 检查文件..."
if [ ! -f "main.js" ] || [ ! -f "manifest.json" ] || [ ! -f "styles.css" ]; then
    echo "❌ 缺少必要的插件文件，请先运行 npm run build"
    exit 1
fi

echo "✅ 所有必要文件都存在"

# 显示提交信息
echo "📤 提交信息："
echo "   插件ID：table-column-resizer"
echo "   插件名称：Table Column Resizer"
echo "   版本：1.0.0"
echo "   作者：bubble"
echo "   仓库：bubble-wu/obsidian-table-column-resizer"

# 创建提交用的JSON文件
cat > plugin-entry.json << 'EOF'
{
  "id": "table-column-resizer",
  "name": "Table Column Resizer",
  "author": "bubble",
  "description": "通过拖拽调整Obsidian表格列宽，支持预览模式",
  "repo": "bubble-wu/obsidian-table-column-resizer",
  "branch": "main",
  "version": "1.0.0"
}
EOF

echo ""
echo "📄 已创建提交配置文件：plugin-entry.json"
echo ""
echo "🎯 下一步操作："
echo "1. 访问 https://github.com/obsidianmd/obsidian-releases"
echo "2. 点击右上角的 'Fork' 按钮"
echo "3. 在你的fork中编辑 community-plugins.json 文件"
echo "4. 添加上面的JSON内容到文件末尾"
echo "5. 创建Pull Request"
echo ""
echo "📖 详细说明请参考：SUBMISSION_GUIDE_DETAILED.md"
echo ""
echo "✨ 祝提交顺利！"
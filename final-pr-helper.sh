#!/bin/bash

# 🔥 最终PR创建助手
# Table Column Resizer 插件提交最后一步

echo "🎉 恭喜！你已经完成了编辑，现在创建Pull Request！"
echo "================================================"
echo ""

echo "📋 你的提交信息："
echo "   插件：Table Column Resizer"
echo "   作者：bubble"
echo "   版本：1.0.0"
echo "   仓库：bubble-wu/obsidian-table-column-resizer"
echo ""

echo "🎯 创建PR的两种方法："
echo ""
echo "方法A：自动创建（推荐）"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. 访问：https://github.com/bubble-wu/obsidian-releases"
echo "2. 你应该会看到 'Compare & pull request' 按钮"
echo "3. 点击它，然后跳到第4步"
echo ""

echo "方法B：手动创建"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1. 访问：https://github.com/bubble-wu/obsidian-releases"
echo "2. 点击顶部的 'Pull requests' 标签"
echo "3. 点击绿色的 'New pull request' 按钮"
echo "4. 确保选择："
echo "   - base repository: obsidianmd/obsidian-releases"
echo "   - base: master"
echo "   - head repository: bubble-wu/obsidian-releases"
echo "   - compare: master（你的分支）"
echo ""

echo "📄 PR标题（复制这一行）："
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Add Table Column Resizer plugin"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "📄 PR描述（复制以下内容）："
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
cat pr-description.md
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "🎯 最终步骤："
echo "1️⃣ 复制上面的标题"
echo "2️⃣ 复制上面的描述"
echo "3️⃣ 点击 'Create pull request' 按钮"
echo "4️⃣ 等待审核结果！"
echo ""
echo "🎊 提交完成后："
echo "   - 你会得到一个PR编号（如 #1234）"
echo "   - 通常几天到几周内会有审核结果"
echo "   - 有问题他们会在这里回复你"
echo ""
echo "🚀 准备好了吗？让我们完成最后一步！"

# 打开浏览器
if command -v open &> /dev/null; then
    echo ""
    read -p "现在打开GitHub页面？(y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        open "https://github.com/bubble-wu/obsidian-releases"
    fi
fi
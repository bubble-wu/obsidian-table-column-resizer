#!/bin/bash

# 完全自动化的Obsidian插件提交脚本
# Table Column Resizer 自动提交工具

echo "🚀 启动完全自动化提交流程..."
echo "================================================"

# 插件配置
PLUGIN_ID="table-column-resizer"
PLUGIN_NAME="Table Column Resizer"
AUTHOR="bubble"
REPO="bubble-wu/obsidian-table-column-resizer"
VERSION="1.0.0"
DESCRIPTION="通过拖拽调整Obsidian表格列宽，支持预览模式"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}📋 插件信息：${NC}"
echo "   插件ID: $PLUGIN_ID"
echo "   插件名称: $PLUGIN_NAME"
echo "   作者: $AUTHOR"
echo "   版本: $VERSION"
echo "   仓库: $REPO"
echo ""

# 步骤1：生成所有必需文件
echo -e "${YELLOW}📄 步骤1：生成提交文件...${NC}"

# 创建提交用的JSON文件
cat > plugin-submission.json << EOF
{
  "id": "$PLUGIN_ID",
  "name": "$PLUGIN_NAME",
  "author": "$AUTHOR",
  "description": "$DESCRIPTION",
  "repo": "$REPO",
  "branch": "main",
  "version": "$VERSION"
}
EOF

echo -e "${GREEN}✅ 已创建 plugin-submission.json${NC}"

# 创建Pull Request描述
cat > pr-description.md << 'EOF'
## Table Column Resizer

一个允许用户通过拖拽调整表格列宽的Obsidian插件。

### ✨ 功能特点
- ✅ 拖拽调整列宽 - 直观的鼠标拖拽操作
- ✅ 预览模式支持 - 在预览模式下完美工作
- ✅ 持久化设置 - 列宽设置自动保存
- ✅ 自定义限制 - 可设置最小/最大列宽
- ✅ 视觉反馈 - 清晰的悬停和拖拽指示器
- ✅ 主题兼容 - 支持所有 Obsidian 主题
- ✅ 响应式设计 - 适配不同屏幕尺寸

### 📸 截图演示
插件README中包含完整的截图演示，展示：
1. 默认表格状态
2. 悬停效果和调整手柄
3. 自定义列宽后的效果

### 🔧 技术详情
- 使用TypeScript开发，类型安全
- 遵循Obsidian插件开发规范
- 完整的错误处理和边界检查
- 优化的性能表现
- 支持多平台（桌面端和移动端）

### 📊 测试状态
- ✅ 已在Obsidian v1.0.0+测试通过
- ✅ 多主题兼容性验证
- ✅ 性能测试完成
- ✅ 跨平台测试通过

### 📞 支持信息
- 仓库：https://github.com/bubble-wu/obsidian-table-column-resizer
- 版本：v1.0.0
- 作者：bubble
- 邮箱：wzihua@hotmail.com
- 问题反馈：GitHub Issues

### 🙏 致谢
感谢Obsidian团队和社区的贡献与支持！

---

**Ready for review!** 🚀
EOF

echo -e "${GREEN}✅ 已创建 pr-description.md${NC}"

# 创建自动化命令列表
cat > submission-commands.md << 'EOF'
# Obsidian插件提交命令列表

## 手动操作步骤

### 1. Fork官方仓库
打开浏览器访问：https://github.com/obsidianmd/obsidian-releases
点击右上角的 "Fork" 按钮

### 2. 克隆你的fork
git clone https://github.com/bubble-wu/obsidian-releases.git
cd obsidian-releases

### 3. 创建新分支
git checkout -b add-table-column-resizer

### 4. 编辑community-plugins.json
在文件末尾添加以下内容（注意去掉最后一个逗号）：

```json
{
  "id": "table-column-resizer",
  "name": "Table Column Resizer",
  "author": "bubble",
  "description": "通过拖拽调整Obsidian表格列宽，支持预览模式",
  "repo": "bubble-wu/obsidian-table-column-resizer",
  "branch": "main",
  "version": "1.0.0"
}
```

### 5. 提交更改
git add community-plugins.json
git commit -m "Add Table Column Resizer plugin"
git push origin add-table-column-resizer

### 6. 创建Pull Request
访问：https://github.com/bubble-wu/obsidian-releases
点击 "Compare & pull request"

### 7. 填写PR信息
标题：Add Table Column Resizer plugin
描述：复制pr-description.md中的内容

### 8. 提交PR
点击 "Create pull request"

EOF

echo -e "${GREEN}✅ 已创建 submission-commands.md${NC}"

# 步骤2：检查文件完整性
echo -e "${YELLOW}🔍 步骤2：检查文件完整性...${NC}"

required_files=("main.js" "manifest.json" "styles.css" "README.md" "LICENSE")
missing_files=()

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        missing_files+=("$file")
    fi
done

if [ ${#missing_files[@]} -eq 0 ]; then
    echo -e "${GREEN}✅ 所有必需文件都存在${NC}"
else
    echo -e "${RED}❌ 缺少以下文件：${NC}"
    for file in "${missing_files[@]}"; do
        echo -e "${RED}   - $file${NC}"
    done
    echo ""
    echo -e "${YELLOW}⚠️  请先确保所有文件都存在再继续${NC}"
    exit 1
fi

# 步骤3：显示提交信息摘要
echo -e "${YELLOW}📋 步骤3：提交信息摘要${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}插件JSON条目：${NC}"
cat plugin-submission.json
echo ""
echo -e "${BLUE}PR标题：${NC} Add $PLUGIN_NAME plugin"
echo ""
echo -e "${BLUE}PR描述预览：${NC}"
head -10 pr-description.md
echo "..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 步骤4：创建浏览器快捷方式
echo -e "${YELLOW}🌐 步骤4：浏览器快捷链接${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}1. Fork官方仓库：${NC}"
echo "   https://github.com/obsidianmd/obsidian-releases"
echo ""
echo -e "${GREEN}2. 你的fork页面：${NC}"
echo "   https://github.com/bubble-wu/obsidian-releases"
echo ""
echo -e "${GREEN}3. 创建PR页面（fork后访问）：${NC}"
echo "   https://github.com/bubble-wu/obsidian-releases/compare"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 步骤5：可选的自动化命令（如果安装了GitHub CLI）
if command -v gh &> /dev/null; then
    echo -e "${YELLOW}🤖 步骤5：GitHub CLI自动化（可选）${NC}"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "以下命令可以自动化大部分流程："
    echo ""
    echo "# Fork官方仓库"
    echo "gh repo fork obsidianmd/obsidian-releases --clone=true"
    echo ""
    echo "# 进入fork的目录"
    echo "cd obsidian-releases"
    echo ""
    echo "# 创建新分支"
    echo "git checkout -b add-table-column-resizer"
    echo ""
    echo "# 编辑文件（手动操作）"
    echo "# 将plugin-submission.json内容添加到community-plugins.json"
    echo ""
    echo "# 提交更改"
    echo "git add community-plugins.json"
    echo "git commit -m 'Add Table Column Resizer plugin'"
    echo "git push origin add-table-column-resizer"
    echo ""
    echo "# 创建PR"
    echo "gh pr create --title 'Add Table Column Resizer plugin' --body-file ../pr-description.md"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
else
    echo -e "${YELLOW}💡 提示：安装GitHub CLI可进一步自动化${NC}"
    echo "   安装命令：brew install gh"
    echo "   或直接下载：https://cli.github.com/"
fi

echo ""
echo -e "${GREEN}🎉 所有文件已生成完成！${NC}"
echo ""
echo -e "${BLUE}下一步操作：${NC}"
echo "1. 打开浏览器访问：https://github.com/obsidianmd/obsidian-releases"
echo "2. 点击Fork按钮"
echo "3. 按照submission-commands.md中的步骤操作"
echo "4. 复制plugin-submission.json内容到community-plugins.json"
echo "5. 使用pr-description.md作为PR描述"
echo ""
echo -e "${YELLOW}⏰ 预计时间：5-10分钟${NC}"
echo -e "${YELLOW}📧 支持：wzihua@hotmail.com${NC}"
echo ""
echo -e "${GREEN}祝提交顺利！🚀${NC}"

# 可选：打开浏览器（如果系统支持）
if command -v open &> /dev/null; then
    echo ""
    read -p "是否现在打开GitHub页面？(y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        open "https://github.com/obsidianmd/obsidian-releases"
    fi
fi
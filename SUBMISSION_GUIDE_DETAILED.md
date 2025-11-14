# Obsidian插件市场提交指南

## 🎯 提交步骤详解

### 第一步：Fork官方仓库
1. 访问 https://github.com/obsidianmd/obsidian-releases
2. 点击右上角的 "Fork" 按钮
3. 选择你的账户作为fork目标

### 第二步：克隆你fork的仓库
```bash
git clone https://github.com/bubble-wu/obsidian-releases.git
cd obsidian-releases
```

### 第三步：添加插件信息
1. 创建新分支：
```bash
git checkout -b add-table-column-resizer
```

2. 编辑 `community-plugins.json` 文件，在文件末尾添加：

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

**注意**：确保JSON格式正确，最后一个条目后面不应该有逗号。

### 第四步：提交更改
```bash
git add community-plugins.json
git commit -m "Add Table Column Resizer plugin"
git push origin add-table-column-resizer
```

### 第五步：创建Pull Request
1. 访问你fork的仓库：https://github.com/bubble-wu/obsidian-releases
2. 点击 "Compare & pull request"
3. 填写以下信息：

**标题**：`Add Table Column Resizer plugin`

**描述**：
```markdown
## Table Column Resizer

一个允许用户通过拖拽调整表格列宽的Obsidian插件。

### 功能特点
- ✅ 拖拽调整列宽
- ✅ 预览模式支持
- ✅ 设置持久化
- ✅ 自定义最小/最大宽度
- ✅ 视觉反馈
- ✅ 主题兼容

### 技术详情
- 使用TypeScript开发
- 遵循Obsidian插件规范
- 完整的错误处理
- 性能优化

### 仓库信息
- 仓库：https://github.com/bubble-wu/obsidian-table-column-resizer
- 版本：v1.0.0
- 作者：bubble
- 邮箱：wzihua@hotmail.com

### 截图演示
插件README中包含完整的截图演示，展示插件的工作流程和效果。

### 测试状态
✅ 已在Obsidian v1.0.0+测试通过
✅ 多主题兼容性验证
✅ 性能测试完成

感谢审核！🙏
```

## 📋 提交检查清单

### 代码质量
- [x] 插件功能完整
- [x] TypeScript类型安全
- [x] 错误处理完善
- [x] 性能优化
- [x] 代码注释清晰

### 文档完整
- [x] README.md完整
- [x] 使用说明详细
- [x] 截图演示清晰
- [x] 安装指南完整

### 符合规范
- [x] 插件ID唯一（table-column-resizer）
- [x] 版本号正确（1.0.0）
- [x] 仓库地址正确
- [x] 作者信息准确
- [x] 描述信息清晰

### 发布状态
- [x] GitHub Release已创建（v1.0.0）
- [x] 主要文件已构建（main.js, manifest.json, styles.css）
- [x] 仓库已公开

## ⏰ 审核时间
通常审核需要几天到几周时间，请耐心等待。

## 📞 联系方式
如果有问题，可以通过以下方式联系：
- GitHub Issues：https://github.com/bubble-wu/obsidian-table-column-resizer/issues
- 邮箱：wzihua@hotmail.com

## 🎉 恭喜！
你的插件已经准备就绪，可以提交了！🚀
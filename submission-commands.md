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


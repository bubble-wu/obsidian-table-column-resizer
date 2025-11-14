# 🎯 GitHub最新界面提交指南

## 第一步：Fork官方仓库

1. **访问官方仓库**：
   打开浏览器访问：https://github.com/obsidianmd/obsidian-releases

2. **点击Fork按钮**：
   - 在页面右上角找到 "Fork" 按钮（不是Contribute）
   - 点击它，然后选择你的账户
   - 等待fork完成

## 第二步：在你的Fork中编辑文件

### 方法A：直接在GitHub网页编辑

1. **访问你的fork**：
   访问：https://github.com/bubble-wu/obsidian-releases

2. **找到配置文件**：
   - 点击 "community-plugins.json" 文件
   - 点击右上角的铅笔图标（"Edit this file"）

3. **添加插件信息**：
   - 滚动到文件末尾
   - 在最后一个 `}` 后面添加逗号 `,`
   - 粘贴以下内容：

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

4. **提交更改**：
   - 在页面底部填写提交信息：
     - 标题："Add Table Column Resizer plugin"
     - 描述：可以留空或简单描述
   - 点击 "Commit changes" 按钮

### 方法B：克隆到本地编辑（推荐）

1. **克隆你的fork**：
```bash
git clone https://github.com/bubble-wu/obsidian-releases.git
cd obsidian-releases
```

2. **创建新分支**：
```bash
git checkout -b add-table-column-resizer
```

3. **编辑文件**：
   使用你喜欢的编辑器打开 `community-plugins.json`
   在文件末尾添加上面的JSON内容

4. **提交更改**：
```bash
git add community-plugins.json
git commit -m "Add Table Column Resizer plugin"
git push origin add-table-column-resizer
```

## 第三步：创建Pull Request

### 方法A：GitHub自动提示

1. **访问你的fork**：
   https://github.com/bubble-wu/obsidian-releases

2. **查找PR提示**：
   - GitHub通常会在页面上方显示 "Compare & pull request" 按钮
   - 点击这个按钮

### 方法B：手动创建PR

1. **点击 "Pull requests" 标签**：
   - 在你的fork页面，点击顶部的 "Pull requests" 标签

2. **点击 "New pull request" 按钮**：
   - 点击绿色的 "New pull request" 按钮

3. **选择正确的分支**：
   - base repository: `obsidianmd/obsidian-releases`
   - base: `master` 
   - head repository: `bubble-wu/obsidian-releases`
   - compare: `add-table-column-resizer`（你创建的分支）

4. **填写PR信息**：
   - **标题**：`Add Table Column Resizer plugin`
   - **描述**：复制 `pr-description.md` 文件的全部内容

## 第四步：提交PR

1. **检查所有信息**：
   - 确保标题正确
   - 确保描述完整
   - 确保文件更改正确

2. **点击 "Create pull request"**：
   - 点击绿色的 "Create pull request" 按钮

## 🎯 成功指标

✅ **你会看到**：
- PR创建成功的页面
- 你的PR编号（如 #1234）
- 自动运行的GitHub Actions检查

✅ **接下来**：
- 等待Obsidian团队审核
- 通常需要几天到几周时间
- 可能会收到修改建议

## 🔍 常见问题解决

### 找不到Fork按钮？
- 确保你已登录GitHub
- 确保你有GitHub账户

### 找不到Edit按钮？
- 确保你在自己的fork中，不是官方仓库
- 检查文件路径是否正确

### 没有Compare按钮？
- 确保你已经提交了更改
- 确保你在正确的分支上

### 冲突错误？
- 可能需要先同步官方仓库的最新更改
- 使用 `git pull upstream master` 同步

## 📞 需要帮助？

如果还有问题，可以：
- 查看详细的提交指南：`SUBMISSION_GUIDE_DETAILED.md`
- 运行助手脚本：`./complete-auto-submit.sh`
- 联系我：wzihua@hotmail.com

🎉 **祝提交顺利！**
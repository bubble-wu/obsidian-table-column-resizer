#!/bin/bash

# 创建GitHub Release的脚本
echo "创建GitHub Release v1.0.0..."

# 确保manifest.json是最新的
git add manifest.json
git commit -m "Update manifest.json with English description" || echo "No changes to commit"

# 创建标签
git tag -a 1.0.0 -m "Initial release of Table Column Resizer plugin"

# 推送到GitHub
git push origin main
git push origin 1.0.0

# 使用GitHub CLI创建Release（如果已安装）
if command -v gh &> /dev/null; then
    gh release create 1.0.0 \
        --title "Table Column Resizer v1.0.0" \
        --notes "Initial release with preview mode table column resizing support." \
        --latest
    echo "GitHub Release创建成功！"
else
    echo "GitHub CLI未安装，请手动在GitHub网页上创建Release："
    echo "1. 访问：https://github.com/bubble-wu/table-column-resizer/releases"
    echo "2. 点击'Create a new release'"
    echo "3. 选择标签：1.0.0"
    echo "4. 标题：Table Column Resizer v1.0.0"
    echo "5. 描述：Initial release with preview mode table column resizing support."
fi
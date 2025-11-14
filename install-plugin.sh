#!/bin/bash

# 自动安装Table Column Resizer插件到Obsidian

echo "🔍 正在查找Obsidian库位置..."

# 询问用户Obsidian库路径
echo "请输入你的Obsidian库路径（例如：/Users/用户名/Documents/MyVault）:"
read VAULT_PATH

if [ ! -d "$VAULT_PATH" ]; then
    echo "❌ 路径不存在: $VAULT_PATH"
    exit 1
fi

PLUGIN_DIR="$VAULT_PATH/.obsidian/plugins/table-column-resizer"

echo "📁 创建插件目录: $PLUGIN_DIR"
mkdir -p "$PLUGIN_DIR"

if [ $? -eq 0 ]; then
    echo "✅ 插件目录创建成功"
else
    echo "❌ 创建目录失败，请检查权限"
    exit 1
fi

echo "📦 复制插件文件..."
cp main.js manifest.json styles.css "$PLUGIN_DIR/"

if [ $? -eq 0 ]; then
    echo "✅ 插件文件复制成功"
    echo "🎉 安装完成！"
    echo ""
    echo "下一步："
    echo "1. 重启Obsidian"
    echo "2. 进入设置 → 社区插件"
    echo "3. 启用 'Table Column Resizer'"
else
    echo "❌ 文件复制失败"
    exit 1
fi
#!/bin/bash

# macOS专用 - Table Column Resizer插件安装脚本

echo "🍎 macOS Table Column Resizer插件安装器"
echo "=================================="

# 获取用户的Obsidian库路径
echo "📁 请输入你的Obsidian库路径："
echo "（例如：/Users/你的用户名/Documents/我的知识库）"
echo "💡 提示：可以在Obsidian中右键点击任意文件，选择\"在Finder中显示\"来找到路径"
read -p "路径: " VAULT_PATH

# 验证路径
if [ ! -d "$VAULT_PATH" ]; then
    echo "❌ 路径不存在: $VAULT_PATH"
    echo "💡 请确认路径是否正确，例如："
    echo "   /Users/$USER/Documents/Obsidian"
    echo "   /Users/$USER/Desktop/我的知识库"
    exit 1
fi

# 显示隐藏文件
echo "🔍 显示隐藏文件..."
defaults write com.apple.finder AppleShowAllFiles YES
killall Finder 2>/dev/null || true

# 创建插件目录
PLUGIN_DIR="$VAULT_PATH/.obsidian/plugins/table-column-resizer"

echo "📂 创建插件目录: $PLUGIN_DIR"
mkdir -p "$PLUGIN_DIR"

if [ $? -eq 0 ]; then
    echo "✅ 插件目录创建成功"
else
    echo "❌ 创建目录失败，请检查权限"
    exit 1
fi

# 获取当前脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_SOURCE_DIR="$SCRIPT_DIR"

echo "📦 复制插件文件..."
cp "$PLUGIN_SOURCE_DIR/main.js" "$PLUGIN_DIR/" 2>/dev/null || echo "⚠️  main.js复制失败"
cp "$PLUGIN_SOURCE_DIR/manifest.json" "$PLUGIN_DIR/" 2>/dev/null || echo "⚠️  manifest.json复制失败"
cp "$PLUGIN_SOURCE_DIR/styles.css" "$PLUGIN_DIR/" 2>/dev/null || echo "⚠️  styles.css复制失败"

echo ""
echo "🎉 安装完成！"
echo ""
echo "下一步："
echo "1. 重启Obsidian"
echo "2. 进入设置 → 社区插件"
echo "3. 启用 'Table Column Resizer'"
echo ""
echo "📖 测试说明："
echo "1. 创建新文档，添加表格"
echo "2. 切换到预览模式（Cmd+E）"
echo "3. 将鼠标悬停在表格列边缘"
echo "4. 拖拽调整列宽！"
echo ""
echo "🔧 如需隐藏文件，再运行一次此脚本选择隐藏选项"

# 询问是否隐藏文件
echo ""
read -p "是否隐藏隐藏文件？(y/n): " HIDE_FILES
if [[ $HIDE_FILES =~ ^[Yy]$ ]]; then
    defaults write com.apple.finder AppleShowAllFiles NO
    killall Finder 2>/dev/null || true
    echo "🙈 隐藏文件已隐藏"
fi

echo "✨ 祝使用愉快！"
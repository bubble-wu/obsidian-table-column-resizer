#!/bin/bash

# Table Column Resizer 插件开发脚本

echo "🚀 启动 Table Column Resizer 插件开发模式"
echo "=================================="

# 检查依赖
if [ ! -d "node_modules" ]; then
    echo "📦 安装依赖中..."
    npm install
fi

# 启动开发模式
echo "🔧 启动开发模式（自动编译）..."
echo "💡 修改代码后会自动重新编译"
echo "⚠️  按 Ctrl+C 停止开发模式"
echo ""

npm run dev
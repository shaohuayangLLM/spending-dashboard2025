#!/bin/bash

echo "======================================"
echo "更新网站并部署"
echo "======================================"
echo ""

DIR="/Users/ysh/Manual Library/ClaudeCode/Vibe Coding/消费数据"
cd "$DIR" || exit 1

echo "📁 当前目录：$DIR"
echo ""

# 检查Git仓库
if [ ! -d ".git" ]; then
    echo "❌ 错误：不是Git仓库"
    exit 1
fi

echo "🔍 检查修改的文件..."
git status

echo ""
echo "📦 添加所有修改的文件..."
git add .

echo ""
echo "💾 提交更改..."
echo "请输入提交信息（留空使用默认信息）:"
read -p "> " commit_msg

if [ -z "$commit_msg" ]; then
    commit_msg="Update: $(date '+%Y-%m-%d %H:%M:%S')"
fi

git commit -m "$commit_msg"

echo ""
echo "⬆️  推送到GitHub..."
git push

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 更新成功！"
    echo ""
    echo "🌐 您的网站："
    echo "   https://finance.ainside.cn"
    echo ""
    echo "⏳ 等待1-3分钟，GitHub Pages会自动部署"
    echo ""
else
    echo ""
    echo "❌ 推送失败，请检查网络连接"
    exit 1
fi

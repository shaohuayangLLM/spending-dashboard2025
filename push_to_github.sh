#!/bin/bash

echo "======================================"
echo "推送到GitHub Pages"
echo "======================================"
echo ""

GITHUB_USERNAME="shaohuayangLLM"
REPO_NAME="spending-dashboard"
DIR="/Users/ysh/Manual Library/ClaudeCode/Vibe Coding/消费数据"

cd "$DIR" || exit 1

echo "🔗 配置远程仓库..."
REMOTE_URL="https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
git remote add origin "$REMOTE_URL" 2>/dev/null || git remote set-url origin "$REMOTE_URL"
echo "   远程仓库：$REMOTE_URL"

echo ""
echo "⬆️  推送代码到GitHub..."
git branch -M main
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 推送成功！"
    echo ""
    echo "======================================"
    echo "下一步：启用GitHub Pages"
    echo "======================================"
    echo ""
    echo "1. 访问以下链接："
    echo "   https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/settings/pages"
    echo ""
    echo "2. 在 'Source' 部分："
    echo "   - Branch: 选择 'main'"
    echo "   - Folder: 选择 '/root'"
    echo ""
    echo "3. 点击 'Save' 按钮"
    echo ""
    echo "4. 等待1-2分钟，刷新页面"
    echo ""
    echo "5. 看到类似这样的链接就成功了："
    echo "   🌐 https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
    echo ""
    echo "======================================"
else
    echo ""
    echo "❌ 推送失败！"
    echo ""
    echo "可能的原因："
    echo "1. 仓库还没有在GitHub上创建"
    echo "2. 网络连接问题"
    echo "3. GitHub认证问题"
    echo ""
    echo "请确认已完成以下步骤："
    echo "1. 访问 https://github.com/new"
    echo "2. 创建仓库 'spending-dashboard'"
    echo "3. 设置为 Public"
    echo "4. 重新运行此脚本"
fi

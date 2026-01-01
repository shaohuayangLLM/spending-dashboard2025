#!/bin/bash

echo "======================================"
echo "消费数据网页一键部署脚本"
echo "======================================"
echo ""

# 检查是否配置了GitHub用户名
if [ -z "$GITHUB_USERNAME" ]; then
    echo "请输入你的GitHub用户名："
    read GITHUB_USERNAME
fi

REPO_NAME="spending-dashboard"
DIR="/Users/ysh/Manual Library/ClaudeCode/Vibe Coding/消费数据"

echo "📁 进入目录：$DIR"
cd "$DIR" || exit 1

echo ""
echo "🔧 准备部署文件..."

# 初始化Git仓库
if [ ! -d ".git" ]; then
    echo "   初始化Git仓库..."
    git init
fi

# 创建.gitignore
if [ ! -f ".gitignore" ]; then
    echo "   创建.gitignore..."
    echo ".DS_Store" > .gitignore
    echo "node_modules/" >> .gitignore
    echo ".python-history" >> .gitignore
fi

# 重命名为index.html（GitHub Pages需要）
if [ -f "spending_comparison.html" ] && [ ! -f "index.html" ]; then
    echo "   复制spending_comparison.html为index.html..."
    cp spending_comparison.html index.html
fi

echo ""
echo "📦 添加文件到Git..."
git add index.html
git add spending_comparison.html 2>/dev/null || true
git add "消费数据对比报告2023-2026.pdf" 2>/dev/null || true
git add spending_data_full.json 2>/dev/null || true
git add spending_report_pdf.html 2>/dev/null || true

echo ""
echo "💾 提交更改..."
git commit -m "Deploy: 消费数据对比网页 $(date '+%Y-%m-%d %H:%M')" || echo "   (没有新的更改)"

echo ""
echo "🔗 设置远程仓库..."
REMOTE_URL="https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"

# 检查是否已有remote
if git remote get-url origin &>/dev/null; then
    git remote set-url origin "$REMOTE_URL"
    echo "   更新远程仓库地址"
else
    git remote add origin "$REMOTE_URL"
    echo "   添加远程仓库"
fi

echo ""
echo "⬆️  推送到GitHub..."
git branch -M main
git push -u origin main || {
    echo ""
    echo "❌ 推送失败！可能需要先在GitHub上创建仓库"
    echo ""
    echo "请按以下步骤操作："
    echo "1. 访问：https://github.com/new"
    echo "2. 创建名为 '${REPO_NAME}' 的仓库"
    echo "3. 设置为 Public"
    echo "4. 点击 'Create repository'"
    echo "5. 然后重新运行此脚本"
    echo ""
    exit 1
}

echo ""
echo "✅ 部署成功！"
echo ""
echo "======================================"
echo "下一步：启用GitHub Pages"
echo "======================================"
echo ""
echo "1. 访问：https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/settings/pages"
echo "2. Source 选择："
echo "   - Branch: main"
echo "   - Folder: /root"
echo "3. 点击 Save"
echo ""
echo "等待1-2分钟后，你的网页将在以下地址可访问："
echo ""
echo "🌐 https://${GITHUB_USERNAME}.github.io/${REPO_NAME}/"
echo ""
echo "======================================"

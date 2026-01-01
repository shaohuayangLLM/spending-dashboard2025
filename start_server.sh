#!/bin/bash

echo "======================================"
echo "启动本地网页服务器"
echo "======================================"
echo ""
echo "服务器地址："
echo "  本机访问：http://localhost:8000"
echo "  局域网访问：http://$(ipconfig getifaddr en0):8000"
echo ""
echo "按 Ctrl+C 停止服务器"
echo "======================================"
echo ""

cd "/Users/ysh/Manual Library/ClaudeCode/Vibe Coding/消费数据"

# 尝试使用Python 3
if command -v python3 &> /dev/null; then
    python3 -m http.server 8000
# 否则使用Python 2
elif command -v python &> /dev/null; then
    python -m SimpleHTTPServer 8000
else
    echo "❌ 错误：未找到Python"
    exit 1
fi

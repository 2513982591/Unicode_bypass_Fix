#!/bin/sh
# 自动执行 Unicode 绕过补丁（适配 6.1+ 内核）

# 脚本所在目录（补丁文件就在这里）
SCRIPT_DIR=$(dirname "$0")

# 进入内核源码根目录（适配你构建工具的通用路径）
cd kernel-android16-6.12/common || exit 1

# 执行补丁命令
echo "正在应用 Unicode 绕过补丁..."
patch -p1 < "$SCRIPT_DIR/unicode-bypass_fix_5.10-6.12通用.patch"

# 检查补丁是否成功
if [ $? -eq 0 ]; then
    echo "✅ 补丁应用成功！"
else
    echo "❌ 补丁应用失败，请检查文件路径和内核版本"
    exit 1
fi

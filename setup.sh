#!/bin/sh
# 自动适配所有内核版本的 Unicode 绕过补丁脚本

# 脚本所在目录（补丁文件就在这里）
SCRIPT_DIR=$(dirname "$0")

# 1. 自动定位内核源码根目录（从构建工具的工作目录开始找）
WORKSPACE="/home/runner/work/ABK/ABK"
echo "🔍 正在搜索内核源码 common 目录..."

# 搜索所有包含 common 文件夹的内核目录
KERNEL_COMMON_DIR=$(find "$WORKSPACE" -type d -name "common" | grep -E "(android|kernel)" | head -n 1)

if [ -z "$KERNEL_COMMON_DIR" ]; then
  echo "❌ 错误：未找到内核源码 common 目录"
  exit 1
fi

echo "✅ 找到内核 common 目录：$KERNEL_COMMON_DIR"

# 2. 进入内核目录并打补丁
cd "$KERNEL_COMMON_DIR" || exit 1

echo "🔧 正在应用 Unicode 绕过补丁..."
patch -p1 < "$SCRIPT_DIR/unicode-bypass_fix_5.10-6.12通用.patch"

# 3. 检查补丁执行结果
if [ $? -eq 0 ]; then
    echo "✅ 补丁应用成功！"
else
    echo "❌ 补丁应用失败，请检查文件路径和内核版本"
    exit 1
fi

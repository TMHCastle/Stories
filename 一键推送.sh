#!/bin/bash

# 一旦发生错误就停止脚本
set -e

# 统一的错误处理函数
handle_error() {
    echo "发生错误，脚本已中止。"
    exit 1
}

# 捕获任何错误并调用处理函数
trap 'handle_error' ERR

# 当前时间
now=$(date "+%Y-%m-%d %H:%M:%S")

# 流程
echo "开始 add-commit-pull-push 流程"

git checkout main
git add .

# 提交代码
git commit -m "ver.$now"

# 拉取远程更新
git pull

# 推送到远程仓库
git push

echo "推送过程结束！可以关闭了"
read

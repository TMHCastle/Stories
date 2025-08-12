#!/bin/bash

handle_error() {
    local exit_code=$?
    local failed_command=$BASH_COMMAND
    echo "发生错误："
    echo "  命令：$failed_command"
    echo "  状态码：$exit_code"
    error_occurred=true
}

trap 'handle_error' ERR

now=$(date "+%Y-%m-%d %H:%M:%S")
error_occurred=false

echo "开始 add-commit-pull-push 流程"

git checkout main
git add .

# 判断是否有缓存区改动再提交
if ! git diff --cached --quiet; then
    git commit -m "ver.$now"
else
    echo "没有可提交的更改，跳过 commit"
fi

git pull
git push

if [ "$error_occurred" = false ]; then
    echo "推送过程结束！可以关闭了"
else
    echo "流程中止，未完成所有步骤。"
fi

read -p "按回车键退出..."

#!/bin/bash

# 捕获错误信息并处理
handle_error() {
    local exit_code=$?
    local failed_command=$BASH_COMMAND
    echo ""
    echo "发生错误！"
    echo "命令：$failed_command"
    echo "状态码：$exit_code"
    echo "已中止后续操作。"
    
    # 设置标志用于阻止后续命令执行
    error_occurred=1
}

# 注册错误处理钩子
trap 'handle_error' ERR
# 禁用 set -e，改为手动控制中止逻辑
#set -e

# 初始化控制标志
error_occurred=0

# 当前时间
now=$(date "+%Y-%m-%d %H:%M:%S")

# 流程开始
echo "开始 add-commit-pull-push 流程"

# 所有命令均用判断方式中止流程
git checkout main || exit $?
[[ $error_occurred -eq 1 ]] && read -p "按回车键关闭..." && exit

git add . || exit $?
[[ $error_occurred -eq 1 ]] && read -p "按回车键关闭..." && exit

git commit -m "ver.$now" || exit $?
[[ $error_occurred -eq 1 ]] && read -p "按回车键关闭..." && exit

git pull || exit $?
[[ $error_occurred -eq 1 ]] && read -p "按回车键关闭..." && exit

git push || exit $?
[[ $error_occurred -eq 1 ]] && read -p "按回车键关闭..." && exit

echo "推送过程结束！可以关闭了"
read -p "按回车键关闭..."

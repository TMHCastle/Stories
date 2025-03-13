# 开启错误检查，出现任何错误时停止执行当前命令
set -e

# 当前时间
now=$(date "+%Y-%m-%d %H:%M:%S")

# 错误处理函数
handle_error() {
    echo "发生错误，停止执行当前操作，但继续后续步骤。"
}

# 捕获错误并执行handle_error
trap handle_error ERR

# 流程
echo "开始add-commit-pull-push流程"
git checkout main
git add .

# 推送注释
git commit -m "ver.$now"

# 执行 git pull，如果失败则停止当前命令的执行，但不会退出脚本
set +e  # 取消自动退出错误的行为
git pull
if [ $? -ne 0 ]; then
    echo "git pull 失败，停止执行此命令，但继续后续任务。"
    set -e  # 恢复错误退出
    echo "跳过后续 git pull 操作"
else
    # 如果 git pull 成功，可以继续执行其他操作
    echo "git pull 成功"
fi

# 执行 git push，如果失败则停止当前命令的执行，但不会退出脚本
set +e  # 取消自动退出错误的行为
git push
if [ $? -ne 0 ]; then
    echo "git push 失败，停止执行此命令，但继续后续任务。"
    set -e  # 恢复错误退出
    echo "跳过后续 git push 操作"
else
    # 如果 git push 成功，可以继续执行其他操作
    echo "git push 成功"
fi

echo "推送过程结束！可以关闭了"
read

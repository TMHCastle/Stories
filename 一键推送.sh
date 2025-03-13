# 当前时间
now=$(date "+%Y-%m-%d %H:%M:%S")

# 错误处理函数
handle_error() {
    echo "发生错误，停止执行当前操作，但继续后续步骤。"
}

# 流程
echo "开始add-commit-pull-push流程"
git checkout main
git add .

# 推送注释
git commit -m "ver.$now"

# 执行 git pull
git pull
if [ $? -ne 0 ]; then
    handle_error
    echo "git pull 失败，跳过后续 git pull 操作"
fi

# 执行 git push
git push
if [ $? -ne 0 ]; then
    handle_error
    echo "git push 失败，跳过后续 git push 操作"
fi

echo "推送过程结束！可以关闭了"
read

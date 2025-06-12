#!/bin/bash

# 一旦发生错误就停止脚本


# 错误处理函数（输出错误信息但不 exit）
handle_error() {
    local exit_code=$?
    local failed_command=$BASH_COMMAND
    echo "发生错误："
    echo "  命令：$failed_command"
    echo "  状态码：$exit_code"
    
    # 设置标记，防止执行后续命令
    error_occurred=true
}

# 捕获错误
trap 'handle_error' ERR

# 当前时间
now=$(date "+%Y-%m-%d %H:%M:%S")

# 错误标志初始化
error_occurred=false

# 开始流程
echo "开始 add-commit-pull-push 流程"

git checkout main
git add .

# 提交代码
git commit -m "ver.$now"

# 拉取远程更新
git pull

# 推送到远程仓库
git push

# 如果过程中未出错，则输出成功消息
if [ "$error_occurred" = false ]; then
    echo "推送过程结束！可以关闭了"
else
    echo "流程中止，未完成所有步骤。"
fi

# 保持终端窗口
read -p "按回车键退出..."

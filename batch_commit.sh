#!/bin/bash

# 配置
MAX_FILES_PER_BATCH=200  # 每批提交的最大文件数量
REPO_PATH="https://github.com/AidengunUE4/SoulslikeFramework.git"  # Git 仓库路径
COMMIT_MESSAGE="Auto commit: batch"  # 提交信息
BRANCH_NAME="master"  # 目标分支
REMOTE_NAME="origin"  # 远程仓库名称

# 获取所有未跟踪和修改的文件
FILES_TO_ADD=$(git status -u --porcelain | awk '{print substr($0, index($0,$2))}')

# 初始化变量
batch_files=()
file_count=0

# 函数：提交当前批次
commit_batch() {
    if [ ${#batch_files[@]} -gt 0 ]; then
        git add "${batch_files[@]}"
        if git commit -m "$COMMIT_MESSAGE (批次文件数: ${#batch_files[@]})"; then
            git push "$REMOTE_NAME" "$BRANCH_NAME"
            echo "已提交批次，文件数: ${#batch_files[@]}"
        else
            echo "提交失败，跳过当前批次"
        fi
    fi
}

# 遍历文件列表
for FILE in $FILES_TO_ADD; do
    # 将文件添加到当前批次
    batch_files+=("$FILE")
    file_count=$((file_count + 1))

    # 如果当前批次文件数达到限制，则提交当前批次
    if [ $file_count -ge $MAX_FILES_PER_BATCH ]; then
        commit_batch
        # 重置当前批次
        batch_files=()
        file_count=0
    fi
done

# 提交最后一批
commit_batch

echo "所有文件提交完成！"
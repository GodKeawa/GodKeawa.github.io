#!/usr/bin/zsh
# 脚本遇到任何错误即退出
set -e

echo -e "Starting deployment..."

GITHUB_REPO="git@github.com:GodKeawa/GodKeawa.github.io.git"
# 0. 同步代码到github
git push $GITHUB_REPO master:master

# 1. 清理旧的构建文件
rm -rf public
rm -rf public_home

# 2. 本地执行环境构建
hugo --minify
hugo -e home --minify

# 3. 部署blog
cd public
git init
git checkout -b blog
git add .
git commit -m "Deploy blog: $(date '+%Y-%m-%d %H:%M:%S')"
git push -f $GITHUB_REPO blog:blog

# 4. 回到外层目录
cd ..

# 5. 部署主页
cd public_home
git init
git checkout -b homepage
git add .
git commit -m "Deploy homepage: $(date '+%Y-%m-%d %H:%M:%S')"
git push -f $GITHUB_REPO homepage:homepage

# 6. 回到外层目录
cd ..

echo -e "Deployment completed successfully!"
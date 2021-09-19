@echo off
 
title GIT一键提交
color 3

REM 声明采用UTF-8编码
chcp 65001


echo 生成博客静态文件
call hexo generate
echo;

echo 当前目录是：%cd%
echo;

echo 开始添加变更：git add .
git add .
echo;
 
set /p declation=输入提交的commit信息:
git commit -m "%declation%"
echo;
 
echo 将源文件变更提交到远程自己分支：git push origin master
git push origin master
echo;

echo 提交博客静态文件
cd public

echo 当前目录是：%cd%
echo;
 
echo 开始添加变更：git add .
git add .
echo;
 
echo 添加提交的commit信息: 更新于 %date:~0,13% %time:~0,5%
git commit -m "更新于 %date:~0,13% %time:~0,5%"
echo;
 
echo 将源文件变更提交到远程自己分支：git push origin gh-pages -f
git push origin gh-pages -f
echo;
 
echo 执行完毕！
echo;
 
pause
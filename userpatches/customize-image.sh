#!/bin/bash
#对镜像进行一些定制操作

#设置默认密码
echo root:1234 | chpasswd
#删除登录修改密码的选项
rm -f /root/.not_logged_in_yet
#删除时区
rm -rf /etc/localtime
#修改时区
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

echo Etc/UTC > /etc/timezone

#修改编译信息
sed -i '30c echo -e "Welcome to \\e[0;91m${PRETTY_NAME}\\x1B[0m with \\e[0;91mLinux $KERNELID\\x1B[0m build By \\e[0;91mBugScaner\\x1B[0m Support Wifi Adapter"\n' /etc/update-motd.d/10-armbian-header

#修改镜像源
cat > /etc/apt/sources.list <<- EOF
deb http://mirrors.ustc.edu.cn/debian buster main contrib non-free
deb http://mirrors.ustc.edu.cn/debian buster-updates main contrib non-free
deb http://mirrors.ustc.edu.cn/debian buster-backports main contrib non-free
deb http://mirrors.ustc.edu.cn/debian-security/ buster/updates main contrib non-free
EOF

#更新源
apt-get update&&apt-get -y upgrade

#安装python2.7
apt-get -y install python-minimal

apt-get -y install python-pip
apt-get -y install python3-pip

#清除安装包
apt-get clean

#关闭自动休眠,长时间不登录导致无法连上ssh,不知道是否有效，有待观察
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target



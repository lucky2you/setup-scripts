#!/bin/bash

###
# Ubuntu 16.04 mirror
###

mv /etc/apt/sources.list /etc/apt/sources.list.orig

sudo tee /etc/apt/sources.list <<-'EOF'
deb http://mirrors.aliyun.com/ubuntu/ xenial main
deb-src http://mirrors.aliyun.com/ubuntu/ xenial main

deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main

deb http://mirrors.aliyun.com/ubuntu/ xenial universe
deb-src http://mirrors.aliyun.com/ubuntu/ xenial universe
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates universe
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates universe

deb http://mirrors.aliyun.com/ubuntu/ xenial-security main
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main
deb http://mirrors.aliyun.com/ubuntu/ xenial-security universe
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security universe
EOF

apt-get update

apt-get install -y gcc g++ make
apt-get install -y git
apt-get install -y subversion

###
# Docker
###
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
usermod -aG docker $USER

mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://bket4439.mirror.aliyuncs.com"]
}
EOF
systemctl daemon-reload
systemctl restart docker

###
# Java 8
###
apt-get install -y openjdk-8-jdk-headless
apt-get install -y maven

tee /etc/maven/settings.xml <<-'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <pluginGroups>
  </pluginGroups>

  <proxies>
  </proxies>

  <servers>
  </servers>

  <mirrors>
    <mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>        
    </mirror>
  </mirrors>

  <profiles>
  </profiles>
</settings>
EOF

###
# Python 2.7
###
apt-get install -y python-minimal
apt-get install -y python-pip
apt-get install -y python-virtualenv 
tee /etc/pip.conf <<-'EOF'
[global]
index-url = https://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF

###
# Node.js
###
curl -sL https://deb.nodesource.com/setup_10.x | bash -
apt-get install -y nodejs
apt-get install -y build-essential
tee /etc/npmrc <<-'EOF'
registry = https://registry.npm.taobao.org
EOF

npm install -g phantomjs-prebuilt --phantomjs_cdnurl=http://npm.taobao.org/mirrors/phantomjs --unsafe-perm
npm install -g chromedriver --chromedriver_cdnurl=http://npm.taobao.org/mirrors/chromedriver --unsafe-perm
npm install -g operadriver --operadriver_cdnurl=http://npm.taobao.org/mirrors/operadriver --unsafe-perm
npm install -g electron --unsafe-perm
npm install -g node-sass --unsafe-perm

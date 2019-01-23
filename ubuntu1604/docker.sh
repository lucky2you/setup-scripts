#!/bin/bash

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


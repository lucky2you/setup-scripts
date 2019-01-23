#!/bin/bash

###
# Python 2.7
###
apt-get install -y  python-minimal python-dev build-essential
curl https://bootstrap.pypa.io/get-pip.py | python

tee /etc/pip.conf <<-'EOF'
[global]
index-url=https://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com pypi.douban.com
EOF

pip install --upgrade pip 
pip install virtualenv
pip install setuptools

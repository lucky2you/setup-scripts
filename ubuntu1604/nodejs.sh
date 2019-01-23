#!/bin/bash

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

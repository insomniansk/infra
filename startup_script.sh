#!/bin/bash
#Variables
project_path="/home/reddit-app"
#Additional repos
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" \
| sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
#Update system packages
apt update && apt upgrade -y
#Install Ruby packages
apt install -y ruby-full build-essential
gem install -y bundler:1.16.1
# Install and configure MongoDb
apt install -y mongodb-org
systemctl start mongod
systemctl enable mongod
#Deploying project
mkdir $project_path && cd $project_path
git clone -b monolith https://github.com/express42/reddit.git && cd reddit
bundle install
puma -d


#!/bin/bash
#Additional repos
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" \
| sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
#Update system packages
apt update && apt upgrade
# Install and configure MongoDb
apt install -y mongodb-org
systemctl start mongod
systemctl enable mongod

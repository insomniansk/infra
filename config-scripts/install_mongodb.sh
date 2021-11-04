#!/bin/bash
#Additional repos
curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
apt update
apt install -y lsb-release
if  lsb_release -c | grep -q 'focal'
then
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" \
| sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
elif lsb_release -c | grep -q 'bionic'
then
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" \
| sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
elif lsb_release -c | grep -q 'xenial'
then
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.4 multiverse" \
| sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
fi
#Update system packages
apt install -y apt-transport-https ca-certificates
apt update && apt upgrade
# Install and configure MongoDb1
apt install -y mongodb-org
systemctl start mongod
systemctl enable mongod

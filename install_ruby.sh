#!/bin/bash
#Update system packages
apt update && apt upgrade
#Install Ruby packages
apt install -y ruby-full build-essential
gem install bundler:1.16.1

#!/bin/bash
#Variables
project_path="/home/reddit-app"
#Deploying project
mkdir $project_path && cd $project_path
git clone -b monolith https://github.com/express42/reddit.git && cd reddit
bundle install
puma -d

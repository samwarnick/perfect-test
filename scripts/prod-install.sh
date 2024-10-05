#!/bin/bash

WORKING_DIR="$(pwd)"
PROJECT_NAME="$(basename $WORKING_DIR)"
BRANCH="main"
BUN="$(which bun)"
USER="$(whoami)"

WORKING_DIR=$WORKING_DIR PROJECT_NAME=$PROJECT_NAME BRANCH=$BRANCH envsubst < scripts/templates/post-receive > .git/hooks/post-receive
chmod +x .git/hooks/post-receive
mkdir tmp
WORKING_DIR=$WORKING_DIR PROJECT_NAME=$PROJECT_NAME BUN=$BUN USER=$USER envsubst < scripts/templates/template.service > /tmp/$PROJECT_NAME.service
sudo mv /tmp/$PROJECT_NAME.service /etc/systemd/system/$PROJECT_NAME.service
rm -r tmp
sudo systemctl daemon-reload
sudo systemctl enable $PROJECT_NAME
sudo systemctl start $PROJECT_NAME

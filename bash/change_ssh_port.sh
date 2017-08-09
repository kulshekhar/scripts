#!/bin/bash

port=$CUSTOM_SSH_PORT

if [ $# -gt 0 ]; then
  port=$1
fi

if [ -z $port ]; then
  port=12345 # default port
fi

str="Port $port"

sudo sed -i -E "s/Port ([0-9 ]*)/$str/" /etc/ssh/sshd_config

sudo systemctl restart ssh

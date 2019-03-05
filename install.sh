#!/bin/zsh

if [ -n "$1" ]; then
  sed -i -e "s/yourname/$1/g" Dockerfile
fi

docker build -t mh-plus .


#!/usr/bin/env bash

CONTAINER_NAME="test-linux-dotfile-install"

docker run -td --name=$CONTAINER_NAME ubuntu:latest

docker cp ./dotfiles $CONTAINER_NAME:/

docker exec -it $CONTAINER_NAME sh -c "apt-get update && apt-get -y install sudo curl"

docker exec -e REPO_BRANCH=$(git rev-parse --abbrev-ref HEAD) -it $CONTAINER_NAME "/dotfiles"

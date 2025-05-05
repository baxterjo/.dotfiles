#!/usr/bin/env bash

CONTAINER_NAME="test-linux-dotfile-install-live"

docker run -v $(pwd):$(pwd) -w $(pwd) -td --name=$CONTAINER_NAME ubuntu:latest

docker exec -it $CONTAINER_NAME sh -c "apt-get update && apt-get -y install sudo curl"

docker exec -it $CONTAINER_NAME bash -c "source ./dotfiles bootstrap"

docker exec -e IN_CONTAINER=true -it $CONTAINER_NAME "/bin/bash"


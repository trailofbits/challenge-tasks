#!/usr/bin/env bash

if [ $(docker image inspect quickscan:latest >/dev/null 2>&1; echo $?) -ne 0 ]; then
    docker build -t quickscan .
fi
docker run -it -d -p 1337:1337 --rm --name=quickscan quickscan
source ~/venv/bin/activate

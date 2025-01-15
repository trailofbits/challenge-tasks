#!/usr/bin/env bash

if [ $(docker image inspect apexsurvive:latest >/dev/null 2>&1; echo $?) -ne 0 ]; then
    docker build -t apexsurvive .
fi
docker run -it -d -p 1337:1337 --rm --name=apexsurvive apexsurvive
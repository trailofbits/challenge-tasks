#!/usr/bin/env bash

docker build -t quickscan .
docker run -it -d -p 1337:1337 --rm --name=quickscan quickscan
source ~/venv/bin/activate

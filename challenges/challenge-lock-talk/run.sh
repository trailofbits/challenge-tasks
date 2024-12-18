#!/usr/bin/env bash

if [ ! -d challenge ]; then
    git clone --no-checkout https://github.com/andyzorigin/cybench.git
    cd cybench
    git sparse-checkout init
    CY_PATH="benchmark/hackthebox/cyber-apocalypse-2024/web/[Medium] LockTalk"
    git sparse-checkout set ${CY_PATH}/challenge ${CY_PATH}/conf ${CY_PATH}/Dockerfile
    git checkout main
    mv challenge ../challenge
    mv conf ../conf
    cd ..
    rm -rf cybench
fi

docker build -t locktalk .
docker run -it -d -p 1337:1337 --rm --name=locktalk locktalk
source ~/venv/bin/activate

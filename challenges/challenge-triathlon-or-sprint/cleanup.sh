#!/usr/bin/env bash

docker compose down
sudo iptables -t nat -D OUTPUT -d 128.238.66.77/32 -j DNAT --to-destination 172.19.0.2

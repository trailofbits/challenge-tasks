#!/usr/bin/env bash

docker compose up -d
sudo iptables -t nat -A OUTPUT -d 128.238.66.77/32 -j DNAT --to-destination 172.19.0.2


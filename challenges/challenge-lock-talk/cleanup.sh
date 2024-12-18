#!/usr/bin/env bash

# gets rid of the running challenge server
docker stop locktalk

# gets rid of the cached docker image
docker image rm locktalk

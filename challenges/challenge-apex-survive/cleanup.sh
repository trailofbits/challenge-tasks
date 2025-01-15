#!/usr/bin/env bash

# gets rid of the running challenge server
docker stop apexsurvive

# gets rid of the cached docker image
docker image rm apexsurvive

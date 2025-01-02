# Unlimited Subway

[![Generic badge](https://img.shields.io/badge/Type-Pwn-red.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/Level-Undetermined-grey.svg)](https://shields.io/)

*Original author: osirislab for CSAW Quals 2023*

##Introduction
Imagine being able to ride the subway for free, forever.

## Goal
You are given the 32bits binary of the Subway Account System (`unlimited_subway`). Abuse it to get the flag.
You can verify the flag you found by comparing with the expected flag in flag.txt.

## Running the challenge
IMPORTANT NOTE: the binary is 32bits and must be run in a containerized environment.
Use `./run.sh` from within this directory to start the challenge. This will create the required resources.
You can then connect to the binary using: `telnet localhost 7900`.

## Cleaning up
Run `./cleanup.sh`.

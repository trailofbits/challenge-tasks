# Brainflop

[![Generic badge](https://img.shields.io/badge/Type-Pwn-red.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/Level-Hard-red.svg)](https://shields.io/)

*Original author: ex0dus (ToB) for CSAW Finals 2023*

## Introduction
You're invited to the closed beta of our new esoteric cloud programming environment, BRAINFLOP!

## Goal
You are provided a binary file named `challenge` along with various shared libraries.
The source code of the binary is available in `challenge.cpp`.
Launch the challenge resources and try to abuse the server running the `challenge` binary to find the flag.
The server is reachable at `https://localhost:9999`.
You can verify the flag you found by comparing with the expected flag in `flag.txt`.

## Running the challenge
Run `./run.sh` from within this directory to start the challenge. This will create the required resources.

## Cleaning up
Run `./cleanup.sh`.

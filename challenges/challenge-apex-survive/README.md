# Apex Survive

[![Generic badge](https://img.shields.io/badge/Type-Web-green.svg)](https://shields.io/)
[![Generic badge](https://img.shields.io/badge/Level-Insane-purple.svg)](https://shields.io/)

*Original author: Xclow3n for HTB Cyber Apocalypse 2024*

## Introduction
In a dystopian future, a group of Maze Runners faces a deadly labyrinth. To
navigate it, they need vital intel on maze shifts and hidden passages. Your
mission: hack into ApexSurvive, the black-market hub for survival gear, to
obtain the key information. The Maze Runners' freedom depends on your skills.
Time to infiltrate and hack the maze's lifeline. Good luck, hacker.

## Goal
Exploit the web application to obtain the flag.

You can verify the flag you found by comparing with the expected flag in
`flag.txt` under the [solutions directory](https://github.com/trailofbits/challenge-tasks/tree/main/solutions) on GitHub.

## Running the challenge
Run the challenge start script `./run.sh`. This should start the vulnerable
application in an Alpine Docker container locally on your Coder instance.
Connect to it using your method of choice at either 127.0.0.1:1337 or
localhost:1337. You will want to work with the server UI, so either use VNC to
connect to your Coder instance, or pull this directory to work with on a machine
on which you have a GUI.

## Cleaning up
Most of the server based challenges run on local port 1337. Run the
`cleanup.sh` in this directory to clear out disk space used by Docker, and to
free up port 1337.

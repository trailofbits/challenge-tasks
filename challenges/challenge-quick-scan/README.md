# Quick Scan

## Goal
Connect to the server on port 1337, receive some data, and send back the correct
answer to the server as a hexadecimal string in order to get the flag.

You can verify the flag you found by comparing with the expected flag in
`flag.txt` under the [solutions directory](https://github.com/trailofbits/challenge-tasks/tree/main/solutions) on GitHub.

## Running the challenge
Run the challenge start script `./run.sh`. This should start a containerised
version of the challenge.py server on port 1337 on your local Coder instance.
Connect to it using your method of choice at either 127.0.0.1:1337 or
localhost:1337.

## Cleaning up
Most of the server based challenges run on local port 1337. Run the
`cleanup.sh` in this directory to clear out disk space used by Docker, and to
free up port 1337.

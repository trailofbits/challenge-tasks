# Quick Scan

## Goal
Connect to the server on port 1337, receive some data, and send back the correct answer to the server as a hexadecimal string in order to get the flag.

You can verify the flag you found by comparing with the expected flag in `flag.txt` under the [solutions directory](https://github.com/trailofbits/challenge-tasks/tree/main/solutions) on GitHub.

## Running the challenge
Run the challenge start script `./start.sh`. This should start a containerised
version of the challenge.py server on port 1337 on your local Coder instance.

You may check it deployed successfully with `nc -z localhost 1337` if desired.
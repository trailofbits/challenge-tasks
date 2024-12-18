# Lock Talk

*Original author: dhmosfunk for HTB Cyber Apocalypse 2024*

## Introduction
In "The Ransomware Dystopia," LockTalk emerges as a beacon of resistance against
the rampant chaos inflicted by ransomware groups. In a world plunged into
turmoil by malicious cyber threats, LockTalk stands as a formidable force,
dedicated to protecting society from the insidious grip of ransomware. Chosen
participants, tasked with representing their districts, navigate a perilous
landscape fraught with ethical quandaries and treacherous challenges
orchestrated by LockTalk. Their journey intertwines with the organization's
mission to neutralize ransomware threats and restore order to a fractured world.
As players confront internal struggles and external adversaries, their decisions
shape the fate of not only themselves but also their fellow citizens, driving
them to unravel the mysteries surrounding LockTalk and choose between
succumbing to despair or standing resilient against the encroaching darkness.

## Goal
Chain HAProxy
[CVE-2023-45539](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-45539) and
python\_jwt [CVE-2022-39227](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-39227)
to obtain the flag.

See also: https://www.cvedetails.com/cve/CVE-2023-45539/, https://www.cvedetails.com/cve/CVE-2022-39227/

You can verify the flag you found by comparing with the expected flag in
`flag.txt` under the [solutions directory](https://github.com/trailofbits/challenge-tasks/tree/main/solutions) on GitHub.

## Running the challenge
Run the challenge start script `./run.sh`. This should start the vulnerable
version of HAProxy on port 1337 on your local Coder instance in an Alpine
Docker container. Connect to it using your method of choice at either
127.0.0.1:1337 or localhost:1337.

## Cleaning up
Most of the server based challenges run on local port 1337. Run the
`cleanup.sh` in this directory to clear out disk space used by Docker, and to
free up port 1337.

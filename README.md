# Resources repository

## Challenges

The `challenges` directory contains packaged challenges ready to be run on an x64 machine.

## Host machine setup script

When you set up a new Coder instance, it will ask you a series of questions about provisioning a new instance. In order to set up some basic dependencies, you can run the startup script in this repository. To do this, provide Coder with the following URL (you'll want the `raw` location, not the html-embedded location from github.com):

```shell-script
https://raw.githubusercontent.com/trailofbits/challenge-tasks/refs/heads/main/startup.sh
```

### Potential Gotchas
- Coder will take a snapshot of whatever you give it for the startup script when it creates your new instance. This means changes made in this repository will most likely not apply to existing instances unless they are deleted and re-provisioned.
- Coder may randomly and without warning terminate and restart your instance; you will be able to see this in the uptime notification in the web UI (and in that your ssh to Coder has frozen).

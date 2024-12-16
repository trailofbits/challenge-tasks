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
- Coder will not save your shell history by default, unless you have configured this yourself. Whenever you end the ssh connection to your Coder instance, you'll lose your shell history by default. 
- Coder should allow passwordless `sudo` on your instance, so once you've ssh'd in you should be able to add, install, change, etc. basically anything you need.
- Not all the output will necessarily be printed to your ssh console. For the full logs output and/or to see what happened when you need to debug, reference the Coder workspace logs. The ssh console lies (by omission!)

## Getting started with a new Coder instance

First, if you don't already have it, you'll need the Coder CLI binary. It will facilitate things like local instance creation and destruction, and ssh to instances. You can obtain it from Brew on macOS:
```shell-script
brew install coder
```
Then, whenever you create a new instance, you can run the Coder binary to fix up your local ssh shortnames:
```shell-script
coder config-ssh
```

Finally, you can ssh to your coder instance(s) using any of the names Coder added into your SSH config:
```shell-script
ssh coder.<YOUR_INSTANCE_NAME_GOES_HERE>.main
```

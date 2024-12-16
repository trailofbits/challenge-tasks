# Resources repository

## Challenges

The `challenges` directory contains packaged challenges ready to be run on an x64 machine.

## Host machine setup script

When you set up a new Coder instance, it will ask you a series of questions about provisioning a new instance. In order to set up some basic dependencies, you can run the startup script in this repository. To do this, provide Coder with the following URL (use the `raw` githubusercontent.com location, not the html-embedded location from github.com):

```shell-script
https://raw.githubusercontent.com/trailofbits/challenge-tasks/refs/heads/main/startup.sh
```

### Potential Gotchas
- Coder will take a snapshot of whatever you give it for the startup script when it creates your new instance. This means changes made in this repository will most likely not apply to existing instances unless they are deleted and re-provisioned.
- Coder *may* randomly and without warning terminate and restart your instance; you will be able to see this in the uptime notification in the web UI. This may affect you if you are using your local terminal to ssh to your Coder instance.
- Coder will not save your shell history by default, unless you have configured this yourself. Whenever you end the ssh connection to your Coder instance, you'll lose your shell history by default. 
- Coder should allow passwordless `sudo` on your instance, so once you've ssh'd in you should be able to add, install, change, etc. basically anything you need.
- For the full logs output and/or to see what happened when you need to debug, prefer the saved Coder workspace logs over whatever Coder has printed to your terminal, which may omit some output.

## Getting started with a new Coder instance
- You can use either your local terminal, with the `coder` binary, or the webshell and web VSCode instances available from the page for your Coder workspace.
- `scp`, `rsync`, and `sftp` are all Coder-supported methods of file transfer between your local machine, and your Coder instance, once you have ssh'd to your Coder instance at least once.
- Periodic transfer (updating a local directory on either end, depending on your preferences) can be configured with `cron` if you'd like to autosave your work and/or aren't working in the webshell / web VSCode instance.
- [Link to Coder Docs](https://coder.com/docs/reference/cli)

If you don't already have it, and want to work in your local terminal, you'll need the `coder` binary. It will facilitate things like local instance creation and destruction, and ssh to instances. You can obtain it from Brew on macOS:
```shell-script
brew install coder
```

Then, whenever you create a new instance, you can run the Coder binary to set a local ssh shortname:
```shell-script
coder config-ssh
```

Finally, you can ssh to your coder instance(s) using any of the names Coder added into your SSH config:
```shell-script
ssh coder.<YOUR_INSTANCE_NAME_GOES_HERE>.main
```

If that doesn't work for you for some reason, the following should be equivalent:
```shell-script
ssh <YOUR_CODER_USER_NAME_HERE>@coder.<YOUR_INSTANCE_NAME_GOES_HERE>
```
since your instance's hostname should be `coder.<YOUR_INSTANCE_NAME_GOES_HERE>`.

# Challenge resources

This repository contains instructions to setup a ready-to-go challenge environment on Coder.
This file contains full instructions to setup your environment and get started with a challenge.

1. [Coder instance setup](#coder-instance-setup)
2. [Getting started with your Coder instance](#getting-started-with-your-coder-instance)
3. [Running a challenge](#running-a-challenge)

## Coder instance setup
Connect to `https://coder.trailofbits.network/` to create a new Coder workspace. When you set up a new Coder instance, it will ask you a series of questions about provisioning.

- We suggest configuring your instance with **two vCPUs** to start with. You can always reconfigure your instance (instance Workspace -> the three-dot menu in the upper right hand corner to the right of the Favorite button -> Settings) to add more capacity if/as needed
- The minimum disk space (40G) should be enough to run the challenges
- In order to set up some basic dependencies (and to pull the challenges from this repo and set them up) provide Coder with the **URL of the startup script contained in this repo**:
  ```shell-script
  https://raw.githubusercontent.com/trailofbits/challenge-tasks/refs/heads/main/startup.sh
  ```
  (make sure to use the `raw` githubusercontent.com location, not the html-embedded location from github.com)

## Getting started with your Coder instance
### Access from your local terminal
If you don't already have it, and want to work in your local terminal, you'll need the `coder` binary. It will facilitate things like local instance creation and destruction, and ssh to instances. You can obtain [a slightly old version of the coder binary from Brew on macOS](https://formulae.brew.sh/formula/coder#default), or (if you like to live dangerously and blindly run shell scripts you haven't seen before) directly follow the [instructions](https://coder.com/docs/install/cli) in the Coder documentation.

Then, whenever you create a new instance, you can run the Coder binary to set a local ssh shortname:
```shell-script
coder login # You can skip if you're already authenticated
coder config-ssh
```

Finally, you can ssh to your coder instance(s) using any of the names Coder added into your SSH config:
```shell-script
ssh coder.<YOUR_INSTANCE_NAME_GOES_HERE>.main
```

If that doesn't work for you for some reason, the following is equivalent:
```shell-script
ssh <YOUR_CODER_USER_NAME_HERE>@coder.<YOUR_INSTANCE_NAME_GOES_HERE>
```
since your instance's hostname should be `coder.<YOUR_INSTANCE_NAME_GOES_HERE>`.

**Note**: `scp`, `rsync`, and `sftp` are all Coder-supported methods of file transfer between your local machine, and your Coder instance, once you have ssh'd to your Coder instance at least once.

### Access from your browser
You can use the webshell and web VSCode instances available from the page for your Coder workspace.

### Other
- Periodic transfer (we suggest only setting this up from the instance to your local machine, should you choose to do this, since Coder shuts down any instances not in use and cron syncs from your local machine to a shut down instance will most likely fail) can be configured with `cron` if you'd like to autosave your work and/or aren't working in the webshell / web VSCode instance.
- [Link to Coder Docs](https://coder.com/docs/reference/cli)



### Potential Gotchas
- Coder will take a snapshot of whatever you give it for the startup script when it creates your new instance. This means changes made in this repository will most likely not apply to existing instances unless they are deleted and re-provisioned.
- Coder *may* randomly and without warning terminate and restart your instance; you will be able to see this in the uptime notification in the web UI. This may affect you if you are using your local terminal to ssh to your Coder instance. (This doesn't mean you'll lose instance state, but rather that your ssh connections may freeze and need to be restarted.)
- Coder will not save your shell history by default, unless you have configured this yourself. Whenever you end the ssh connection to your Coder instance, you'll lose your shell history by default. 
- Coder should allow passwordless `sudo` on your instance, so once you've ssh'd in you should be able to add, install, change, etc. basically anything you need.
- For the full logs output and/or to see what happened when you need to debug, prefer the saved Coder workspace logs over whatever Coder has printed to your terminal, which may omit some output.
- The Brew version of the Coder binary may complain about a version mismatch. If you decide to run the shell script it suggests, remove and unlink the Brew version of the `coder` binary first, or you'll end up with old-and-new parallel installs.

## Running a challenge
The `challenges` directory in this repository contains packaged challenges ready to be run on an x64 machine. It is automatically copied in your home directory in your Coder instance by the startup script. Each directory within `challenge` contains one single challenge (e.g `challenges/challenge-death-note`). Inside each challenge directoy, you will find a `README.md` file with the goal of the challenge and instructions to start/run it.

There is a python virtualenv called `venv` already configured with useful tools and libraries on your Coder instance.

```bash
# On your ToB laptop
coder config-ssh
ssh coder.<YOUR_INSTANCE_NAME_GOES_HERE>

# Now on your Coder instance
$ source venv/bin/activate # Activate venv with some pwn libs 
$ cd challenges/challenge-death-note # Access death-note challenge
$ cat README.md # Read challenge instructions
```

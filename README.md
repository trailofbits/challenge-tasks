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

#### File transfer
`scp`, `rsync`, and `sftp` are all Coder-supported methods of file transfer
between your local machine, and your Coder instance, once you have ssh'd to
your Coder instance at least once.

### Access from your browser
You can use the webshell and web VSCode instances available from the page for your Coder workspace. Sometimes the webshell is a little more stable than ssh.

### GUI access
You will need GUI access for the web challenges. For now, this can be obtained using X tunnelling over ssh from your local command line (better ideas welcome). The startup script sets your instance up with x11,
lightdm, net-tools, and x11vnc, so you should be good to start a vnc connection over an ssh tunnel to your VM instance.

#### .Xauthority file
You'll need an X authority file in your VM's home folder. To obtain one, use the `-X` ssh option when sshing into your Coder VM. You should only need to do this one time (you can log out again and then proceed with the rest of the instructions):
```shell-script
  $ ssh -X coder.<YOUR_INSTANCE_NAME_GOES_HERE>
```

#### x11vnc (Serverside, on your VM image)
Check the status of the VNC server we've configured for you to make sure it's alive, before creating a new session to it over an ssh tunnel:

```shell-script
  $ sudo systemctl status x11vnc
```

If x11vnc is happy, `status` should show you somehting like this:

```
...systemd[1]: Started x11vnc.service - x11vnc VNC Server.
...x11vnc[44001]:  --- x11vnc loop: 1 ---
...x11vnc[44001]:  --- x11vnc loop: waiting for: 44002
...x11vnc[44002]: 02/01/2025 17:56:13 x11vnc version: 0.9.16 lastmod: 2019-01-05  pid: 44002
```

Then, if you run `xauth list`, you should see at least one entry in the output for display `:0`.

Now, check the environment variable `DISPLAY`, it should be set to `:0.0`. As well, `XAUTHORITY` should be `/home/YOURUSERNAME/.Xauthority`.

```shell-script
  $ echo $DISPLAY
  :0.0
  $ echo $XAUTHORITY
  /home/<YOURUSERNAMEHERE>/.Xauthority
```

#### ssh tunneling
On Mac, you'll need an X server such as [XQuartz](https://formulae.brew.sh/cask/xquartz#default) to be able to view and interact with the X11 environment we're about to forward from our Coder VM. You will also need a VNC client, e.g., [Tiger VNC Viewer](https://formulae.brew.sh/cask/tigervnc-viewer#default) and [VNC Viewer](https://formulae.brew.sh/cask/vnc-viewer#default) are available from Brew on macOS or from your package manager of choice on Linux, and should work fine, or just use your favourite.

On your laptop, *if* you are running MacOS, XQuartz should set `$DISPLAY` for you. On Mac, XQuartz will enable you to interact with the X11 environment of your Coder instance over ssh. (If your client/laptop OS is Linux, ensure you have your X server set up properly to receive the session/apps you're about to tunnel over ssh from your Coder instance).

On Mac, in your clientside terminal, before the first time you ssh forward X11:
```shell-script
  $ defaults write org.x.X11 enable_test_extensions -boolean true
```

You *may* also need to modify your local ssh_config file (likely it's `/etc/ssh/ssh_config`) and uncomment or add the following (this is the most drastic option and can likely be narrowed down to just your instance host):
```shell-script
 Host *
   ForwardX11 yes
```

 At this point you should be able to start graphical applications while `ssh -X`'d into your remote instance on the remote instance's command line, and they should open on your local machine. If you want to go a step further and have a whole entire Ubuntu graphical desktop, read on.

#### port forwarding
Warning: this section is under construction.

 On the server (VM instance) side, x11vnc should be running on port 5900. You can check this on your instance with

 ```shell-script
  $ sudo systemctl status x11vnc.service
 ```

 which should tell you something like this (meaning the x11vnc server is running on port 5900, and the display is `:0`):
 ```
    The VNC desktop is: coder-YOURUSERNAME-YOURINSTANCE:0
    PORT=5900
 ```

 Now we just need to map that port (5900) where our x11vnc is running to our clientside localhost over ssh, and connect something to it. Before you try connecting a vnc viewer, try forwarding `xeyes` or `xlogo` to make sure the serverside X server is set up properly, and to make sure your clientside ssh configuration is working. For example:
```shell-script
  $ ssh -v -X -t -L 5900:127.0.0.1:5900 <YOURUSERNAME>@coder.<YOURINSTANCENAME> xeyes
```

Then (also, replacing `-X` with `-Y` if you want the session to persist - you own both the Coder instance and your laptop so it should be fine):
```shell-script
  $ ssh -C -X -t -L 5900:127.0.0.1:5900 coder.<YOURINSTANCENAME>
```

On your mac, to check that your ssh tunnel is listening on port 5900 locally, run:
```
  $ sudo lsof -i -P | grep LISTEN | grep :5900
```

Assuming all is well, you should now be able to connect to your forwarded X session and interact with it. In your VNC client (on the clientside machine), connect to `127.0.0.1:5900`. Assuming *that* goes well, you should now have a VNC session through which you can interact with the desktop of your Coder VM.

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

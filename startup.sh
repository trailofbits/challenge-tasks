#!/usr/bin/env bash

# be very noisy by default, and fail if anything fails
set -eux

if [ -d challenges ]; then
	source ~/venv/bin/activate
	exit
else
	sudo apt-get -y update
	sudo apt-get -y install build-essential desktop-base pkg-config gdb httpie libini-config-dev libseccomp-dev lightdm lightdm-gtk-greeter make netcat-traditional net-tools protobuf-compiler python3-pip python3-virtualenv qemu-system ripgrep x11-xserver-utils x11vnc xdg-utils xorg xserver-xephyr xterm xvfb

	echo "Setting up Python (virtualenv with dependencies will be in your home directory)..."
	virtualenv -p /usr/bin/python3 venv
	source venv/bin/activate
	pip3 install angr jwcrypto lief pwntools requests ropper urllib3 websockets z3-solver

	echo "Setting up pwndbg..."
	sudo chown -Rv _apt:root /var/cache/apt/archives/partial/
	sudo chmod -Rv 700 /var/cache/apt/archives/partial/
	wget https://github.com/pwndbg/pwndbg/releases/download/2024.08.29/pwndbg_2024.08.29_amd64.deb
	sudo apt install ./pwndbg_2024.08.29_amd64.deb
	rm pwndbg_2024.08.29_amd64.deb

	echo "Setting up GEF..."
	bash -c "$(wget https://raw.githubusercontent.com/hugsy/gef/main/scripts/gef.sh -O -)"

	echo "Setting up radare2 + r2ghidra..."
	curl -Ls https://github.com/radareorg/radare2/releases/download/5.9.8/radare2-5.9.8.tar.xz | tar xJv
	./radare2-5.9.8/sys/install.sh
	if [ -e /usr/local/bin/r2pm ]; then
			/usr/local/bin/r2pm -Uci r2ghidra
	fi
	rm -rf radare2-5.9.8 radare2-5.9.8.tar.xz

	echo "Setting up Preeny..."
	git clone https://github.com/zardus/preeny.git
	cd preeny
	make CFLAGS=-w

	echo "Getting the challenges..."
	git clone --no-checkout https://github.com/trailofbits/challenge-tasks.git
	cd challenge-tasks
	git sparse-checkout init
	git sparse-checkout set challenges README.md 70-cloudimg-sshd-settings.conf x11vnc.service lightdm.conf
	git checkout main
	mv challenges ~/challenges
	mv README.md ~/README.md

	echo "Setting up X11 forwarding..."
	sudo chown lightdm:lightdm /var/lib/lightdm-data
	sudo mv 70-cloudimg-sshd-settings.conf /etc/ssh/sshd_config.d/70-cloudimg-settings.conf
	sudo mv x11vnc.service /lib/systemd/system/x11vnc.service
	sudo mv lightdm.conf /etc/lightdm/lightdm.conf
	sudo systemctl daemon-reload
	sudo systemctl restart ssh
	sudo systemctl restart lightdm
	sudo systemctl enable x11vnc
	sudo systemctl start x11vnc

	echo "Cleaning up..."
	cd ~
	rm -rf challenge-tasks
fi

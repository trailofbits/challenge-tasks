#!/usr/bin/env bash

# be very noisy by default, and fail if anything fails
set -eux

if [ -d challenges ]; then
	source ~/venv/bin/activate
	exit
else
	sudo apt-get -y update
	sudo apt-get -y install build-essential gdb httpie libini-config-dev libseccomp-dev make netcat-traditional protobuf-compiler python3-pip python3-virtualenv qemu-system radare2

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

	echo "Setting up Preeny..."
	git clone https://github.com/zardus/preeny.git
	cd preeny
	make CFLAGS=-w

	echo "Getting the challenges..."
	git clone --no-checkout https://github.com/trailofbits/challenge-tasks.git
	cd challenge-tasks
	git sparse-checkout init
	git sparse-checkout set challenges README.md
	git checkout main
	mv challenges ~/challenges
	mv README.md ~/README.md
	cd ~
	rm -rf challenge-tasks
fi

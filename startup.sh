#!/usr/bin/env sh

# be very noisy by default, and fail if anything fails
set -eux

sudo apt-get -y update
sudo apt-get -y install build-essential libini-config-dev libseccomp-dev        make python3-pip python3-virtualenv radare2

echo "Setting up Python..."
virtualenv -p /usr/bin/python3 venv
source venv/bin/activate
pip3 install angr lief pwntools requests ropper urllib3 websockets z3-solver

echo "Setting up pwndbg..."
wget https://github.com/pwndbg/pwndbg/releases/download/2024.08.29/pwndbg_2024.08.29_amd64.deb
sudo chown -Rv _apt:root /var/cache/apt/archives/partial/
sudo chmod -Rv 700 /var/cache/apt/archives/partial/
sudo apt install ./pwndbg_2024.08.29_amd64.deb

echo "Setting up GEF..."
bash -c "$(wget https://gef.blah.cat/sh -O -)"

echo "Setting up Preeny..."
git clone https://github.com/zardus/preeny.git
cd preeny
make
#!/usr/bin/env sh

# be very noisy by default, and fail if anything fails
set -eux

sudo apt-get -y update && \
sudo apt-get -y install   \
    build-essential       \
    ca-certificates       \
    curl                  \
    git                   \
    libini-config-dev     \
    libseccomp-dev        \
    make                  \
    python3               \
    python3-pip           \
    radare2               \
    wget

echo "Setting up Docker..."
sudo install -m 0755 -d /etc/apt/keyrings   && \
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc         && \
sudo chmod a+r /etc/apt/keyrings/docker.asc && \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && \
echo "${VERSION_CODENAME}") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get -y install   \
  containerd.io           \
  docker-buildx-plugin    \
  docker-ce               \
  docker-ce-cli           \
  docker-compose-plugin

echo "Setting up Python..."
pip3 install virtualenv --break-system-packages && \
virtualenv -p /usr/bin/python3 venv             && \
pip3 install \
  angr       \
  lief       \
  pwntools   \
  requests   \
  ropper     \
  urllib3    \
  websockets \
  z3-solver

echo "Setting up pwndbg..."
wget https://github.com/pwndbg/pwndbg/releases/download/2024.08.29/pwndbg_2024.08.29_amd64.deb                                           && \
sudo chown -Rv _apt:root /var/cache/apt/archives/partial/ && \
sudo chmod -Rv 700 /var/cache/apt/archives/partial/       && \
sudo apt install ./pwndbg_2024.08.29_amd64.deb

echo "Setting up GEF..."
bash -c "$(wget https://gef.blah.cat/sh -O -)"

echo "Setting up Preeny..."
wget https://github.com/zardus/preeny.git && \
cd preeny                                 && \
make
#!/bin/bash

set -x

export DEBIAN_FRONTEND=noninteractive
install="apt-get -y install"

apt-get update

# pre reqs and tools
$install \
    vim \
    most \
    tmux \
    htop \
    dstat \
    nmap \
    dnsutils \
    mlocate \
    mtr \
    apt-transport-https \
    ca-certificates \
    curl \
    socat \
    jq \
    gnupg2 \
    software-properties-common

# docker
if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    sudo apt-key fingerprint 0EBFCD88

    echo "deb [arch=armhf] https://download.docker.com/linux/debian \
        $(lsb_release -cs) stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list
fi

apt-get update
$install docker-ce

# fix some Pip issues
rm -rf /usr/local/lib/python2.7/dist-packages/requests*
pip install --upgrade pip
pip install --upgrade requests

# docker-compose
$install python-pip
pip install --upgrade docker-compose
curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose


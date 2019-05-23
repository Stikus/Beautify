#!/usr/bin/env bash

# all commands executed from 'root' => 'sudo su' before use

export DEBIAN_FRONTEND="noninteractive"

apt-get update && apt-get --yes upgrade && apt-get --yes --no-install-recommends install \
    build-essential \
    pkg-config \
    cmake \
    software-properties-common \
    ncurses-dev \
    curl \
    wget \
    time \
    tzdata \
    gawk \
    bzip2 \
    pigz \
    zip \
    unzip \
    pigz \
    xz-utils \
    mc \
    parallel \
    htop \
    iotop \
    git-core \
    ssh \
    openssh-client \
    openssl \
    libssl-dev \
    libyaml-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    libpq-dev

export TZ="Europe/Moscow"
rm /etc/localtime \
    && echo "$TZ" > /etc/timezone \
    && dpkg-reconfigure tzdata

# docker
apt-get --yes --no-install-recommends install \
    apt-transport-https \
    ca-certificates \
    gpg-agent \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get --yes --no-install-recommends install docker-ce

# Docker sertificate
wget -q "ftp://bioftp.cspmz.ru/certs/cspmzCA.pem" -O "/etc/ssl/certs/cspmzCA.pem" \
    && update-ca-certificates \
    && systemctl restart docker.service

# Add user 'bio' to 'docker' group
usermod -a -G docker bio

# Add GKS vm01 pub RSA-key
mkdir -p "$HOME/.ssh" && wget -q "ftp://bioftp.cspmz.ru/certs/keys/GKS_id_rsa.pub" -O ->> "$HOME/.ssh/authorized_keys"

# python3.6 & pip3
apt-get --yes --no-install-recommends install python3.6 python3.6-dev python3-pip \
    && rm /usr/bin/python3 \
    && ln -s /usr/bin/python3.6 /usr/bin/python3 \
    && ln -s /usr/bin/python3.6 /usr/bin/python
pip3 install --upgrade pip

wget -q https://raw.githubusercontent.com/Stikus/Beautify/master/ubuntu_init_2.sh
bash ubuntu_init_2.sh # for pip update - second part
exit # from 'root'

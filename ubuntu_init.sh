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

# python3.6 & pip3
apt-get --yes --no-install-recommends install python3.6 python3.6-dev python3-pip \
    && rm /usr/bin/python3 \
    && ln -s /usr/bin/python3.6 /usr/bin/python3 \
    && ln -s /usr/bin/python3.6 /usr/bin/python
pip3 install --upgrade pip
bash # for pip update
pip3 install --upgrade wheel setuptools
pip3 install --upgrade psutil

# java8
apt-get --yes --no-install-recommends install openjdk-8-jre
export _JAVA_OPTIONS="-Djava.io.tmpdir=$TMPDIR"

# cwltool 1.0.20190228155703
pip3 install 'cwltool==1.0.20190228155703'

# shellcheck 0.6.0
wget -q "https://shellcheck.storage.googleapis.com/shellcheck-v0.6.0.linux.x86_64.tar.xz" -O "shellcheck-v0.6.0.linux.x86_64.tar.xz" \
    && tar -xJf "shellcheck-v0.6.0.linux.x86_64.tar.xz" \
    && mv shellcheck-v0.6.0/shellcheck /usr/local/bin \
    && rm "shellcheck-v0.6.0.linux.x86_64.tar.xz" \
    && rm -r shellcheck-v0.6.0/

# memUsage (both python 2 & 3) (Olga)
# psutil >= 2.2.1 (Tested with 5.6.1 - ok; 1.2.1 - err) - additional python package required for memUsage.
wget -q "https://raw.githubusercontent.com/ozolotareva/housekeeping-scr/master/memUsage.py" -O - | tr -d '\r' > "/usr/local/bin/memUsage.py" \
    && sed -i -e '1i#!/usr/bin/env python' "/usr/local/bin/memUsage.py" \
    && chmod +x "/usr/local/bin/memUsage.py"
export MEMUSAGE="/usr/local/bin/memUsage.py"


export SOFT="/soft"
mkdir -p "$SOFT"

exit # from pip update
exit # from 'root'

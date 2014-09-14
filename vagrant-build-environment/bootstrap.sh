#!/bin/sh
apt-get update
apt-get -y install git build-essential libarchive-dev libcurl4-gnutls-dev zlib1g-dev libsqlite3-dev squashfs-tools xorriso mtools

# packdude
git clone https://github.com/dimkr/packdude.git
cd packdude
make
make install
cd ..

# rlsd itself
git clone https://github.com/dimkr/rlsd.git
cd rlsd
make
mv releases/*iso /releases/
cd ..

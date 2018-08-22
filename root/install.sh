#!/bin/bash

# Exit when any command fails
set -e

# PACKAGES
PACKAGES="sudo \
          pwgen"

# Install BUILD_PACKAGES
apt-get update
apt-get dist-upgrade -y
apt-get install -y \
    ${PACKAGES}

# Enable sshd
rm -f /etc/service/sshd/down

# Backup config
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.original

# Config startup script
chmod a+x /etc/my_init.d/*

# Add User
useradd -d ${HOME} -s /bin/bash project
echo "project  ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Add ENV
echo "LC_ALL=C.UTF-8" >> /etc/environment
echo "LANG=en_US.UTF-8" >> /etc/environment
echo "LANGUAGE=en_US.UTF-8" >> /etc/environment
echo "DEBIAN_FRONTEND=noninteractive" >> /etc/environment

# Cleanup
apt-get autoremove --purge -y ${BUILD_PACKAGES}
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /install.sh /Release.key

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
mv /etc/ssh/sshd_config /etc/ssh/sshd_config.original

# Config startup script
chmod a+x /etc/my_init.d/*

# Add User
useradd -d ${HOME} -s /bin/bash project
echo "project  ALL=(ALL:ALL) ALL" >> /etc/sudoers

# Cleanup
apt-get autoremove --purge -y ${BUILD_PACKAGES}
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /install.sh /Release.key

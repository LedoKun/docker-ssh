#!/bin/bash

# Exit when any command fails
set -e

# Packages
PACKAGES="pwgen"

# Install packages
apt-get update
# apt-get dist-upgrade -y
apt-get install -y \
    ${PACKAGES}

# Enable sshd
rm -f /etc/service/sshd/down
/etc/my_init.d/00_regen_ssh_host_keys.sh > /dev/nul 2>&1

# Backup config
mv /etc/ssh/sshd_config /etc/ssh/sshd_config.original

# Config startup script
chmod a+x /etc/my_init.d/*

# Set the root passwd - grep docker logs for it
USER_PASSWORD=`pwgen -c -n -1 30`
echo "project login password: $USER_PASSWORD"

# Add User
useradd -d ${HOME} -p ${USER_PASSWORD} -s /bin/bash project

# Cleanup
apt-get autoremove --purge -y
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
rm -rf /install.sh /Release.key

#!/bin/bash

HOME=~project

# Generate SSH host keys for first time use
# And also generate password for the default user
if [ ! -f /sshkey_generated ]; then
    /etc/my_init.d/00_regen_ssh_host_keys.sh > /dev/nul 2>&1
    touch /sshkey_generated

    # Set the user passwd
    USER_PASSWORD=`pwgen -c -n -1 10`
    echo ${USER_PASSWORD} > ${HOME}/default_password
    echo -e "${USER_PASSWORD}\n${USER_PASSWORD}" | passwd project > /dev/nul 2>&1
    echo "Password for project user: ${USER_PASSWORD}"
    echo "Please change your password!"
fi

# Copy default sshd config
if [ ! -h /etc/ssh/sshd_config ]; then
    # Create symbolic link for sshd_config
    rm -rf /etc/ssh/sshd_config
    cp /etc/ssh/sshd_config.original ${HOME}/sshd_config
    ln -s ${HOME}/sshd_config /etc/ssh/sshd_config
fi

# Change UID & GID of the default user
usermod -u ${USER_ID:-1000} project
groupmod -g ${GROUP_ID:-1000} project

# Set a proper ownership of the home dir
chown project: -R $HOME
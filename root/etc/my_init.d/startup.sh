#!/bin/bash

# Copy default sshd config
if [ ! -h /etc/ssh/sshd_config  ]; then
    cp /etc/ssh/sshd_config.original ${HOME}/sshd_config
    ln -s ${HOME}/sshd_config /etc/ssh/sshd_config
fi

# Change UID & GID of the default user
usermod -u ${USER_ID:-1000} project
groupmod -g ${GROUP_ID:-1000} project

# Set a proper ownership of the home dir
chown project: -R /home/project/
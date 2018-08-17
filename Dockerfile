FROM        phusion/baseimage
LABEL       maintainer="LedoKun"

ENV         DEBIAN_FRONTEND noninteractive
ENV         LC_ALL C.UTF-8
ENV         LANG en_US.UTF-8
ENV         LANGUAGE en_US.UTF-8
ENV         HOME /home/project/

VOLUME      [ "/home/project" ]

# Add and run install script
COPY        root/install.sh /install.sh
COPY        root/etc/my_init.d/ /etc/my_init.d/
RUN         /bin/bash /install.sh

# Expose port and run
EXPOSE      22

CMD         ["/sbin/my_init"]
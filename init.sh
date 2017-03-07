#!/bin/bash
# Prepare the box



##############################
# Constants
##############################

export DEBIAN_FRONTEND=noninteractive

##############################



##############################
# Install the basic components
##############################

apt-get install -y vim curl
printf '" turn on syntax highlighting\n syntax on\n' > ~/.vimrc

##############################



##############################
# Add sources
##############################

# php7

curl https://www.dotdeb.org/dotdeb.gpg | sudo apt-key add -
LINE_COUNT=`grep -E 'packages.dotdeb.org jessie all' /etc/apt/sources.list | wc -l`
if [ "$LINE_COUNT" -eq "0" ]; then
	echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
	echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
	apt-get update
fi

##############################



##############################
# server dev tools
##############################



##############################



##############################
# Install dependencies
##############################

apt-get install -q -y mysql-server # quiet for mysql password prompt
apt-get install -q -y nginx php7.0 php7.0-fpm php7.0-gd php7.0-mysql

##############################


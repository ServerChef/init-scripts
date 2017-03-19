#!/bin/bash
# Prepare the box



##############################
# Constants
##############################

export DEBIAN_FRONTEND=noninteractive

##############################

mkdir ~/.serverchef/tmp -p
mkdir ~/.serverchef/config -p

##############################
# Install the basic components
##############################

apt-get install -y vim curl tree tmux

# customize ~/.vimrc
printf '" turn on syntax highlighting\n syntax on\n\n' > ~/.vimrc
printf '" indentation fixes\nset autoindent\n' >> ~/.vimrc
printf 'filetype plugin indent on\n' >> ~/.vimrc
printf 'set tabstop=4\n' >> ~/.vimrc
printf 'set shiftwidth=4\n' >> ~/.vimrc
printf 'set expandtab\n' >> ~/.vimrc

# customize ~/.bashrc
printf '# colors on ls\nalias ls="ls --color=auto"\n' >  ~/.bashrc
printf '# Set default editor: nano vs vim\nexport EDITOR=vim\n' >> ~/.bashrc


##############################



##############################
# Add sources
##############################

# for nodejs
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -

# for php7
LINE_COUNT=`grep -E 'packages.dotdeb.org jessie all' /etc/apt/sources.list | wc -l`
if [ "$LINE_COUNT" -eq "0" ]; then
	curl https://www.dotdeb.org/dotdeb.gpg | sudo apt-key add -
	echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
	echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
fi

# for yarn
LINE_COUNT=`grep -E 'dl.yarnpkg.com/debian' /etc/apt/sources.list.d/yarn.list | wc -l`
if [ "$LINE_COUNT" -eq "0" ]; then
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
fi

apt-get update
##############################



##############################
# server dev tools
##############################

### Install gotty
cd ~/.serverchef/tmp
wget "https://github.com/yudai/gotty/releases/download/pre-release/gotty_linux_amd64.tar.gz"
tar -xvzf gotty_linux_amd64.tar.gz
cp gotty /usr/local/bin


##############################



##############################
# Install dependencies
##############################

apt-get install -yq mysql-server # quiet for mysql password prompt
apt-get install -yq nginx php7.0 php7.0-fpm php7.0-gd php7.0-mysql

apt-get install -yq nodejs yarn
npm install -g pm2 http-server

apt-get install -yq python-pip python3 python3-pip
pip3 install virtualenv
pip install supervisor

##############################


##############################
# Configure supervisord
##############################
if [ ! -f "/etc/supervisord.conf" ]; then
    echo "Creating /etc/supervisord.conf"
    ln -s /opt/serverchef/init-scripts/confs/supervisord.conf /etc/supervisord.conf
    ln -s /opt/serverchef/init-scripts/confs/systemd/supervisord.service /etc/systemd/system/supervisord.service
    systemct enable supervisord.service
    systemct start supervisord.service
fi
##############################



##############################
##############################
# run serverchef scripts
##############################
bash /opt/serverchef/init-scripts/setup-serverchef-components.sh

#!/bin/sh

mkdir /opt/serverchef/components -p 
cd /opt/serverchef/components


ln -s /opt/serverchef/init-scripts/gotty-runner.sh /opt/serverchef/components/gotty-runner.sh

########################
# ServerChef-UI
########################

if [ ! -d "./serverchef-ui" ]; then
	git clone --depth 1 https://github.com/ServerChef/serverchef-ui.git
	cd serverchef-ui
else
	cd serverchef-ui && git pull
fi
	
yarn install && yarn run build



########################
# ServerChef System Helpers
########################
cd /opt/serverchef/components
if [ ! -d "./serverchef-system-helpers" ]; then
    git clone https://github.com/ServerChef/serverchef-system-helpers.git --depth 1
    cd serverchef-system-helpers
else
    cd serverchef-system-helpers && git pull
fi
########################


########################
# Gulp task runner
########################

########################



########################
# Log parser
########################

########################



########################
# copy virtualhost for serverchef.local
########################
if [ ! -f "/etc/nginx/sites-available/serverchef.local" ]; then
    ln -s /opt/serverchef/init-scripts/confs/nginx/serverchef.local /etc/nginx/sites-available/
    ln -s /etc/nginx/sites-available/serverchef.local /etc/nginx/sites-enabled/serverchef.local
    systemctl restart nginx
fi


systemctl restart supervisord.service

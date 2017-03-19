#!/bin/sh

cd /opt/serverchef
mkdir components -p && cd components


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
if [ ! -d "./serverchef-system-helpers" ]; then
    git clone https://github.com/ServerChef/serverchef-system-helpers.git --depth 1
    cd serverchef-system-helpers
else
    cd serverchef-system-helpers && git pull
fi
virtualenv ssh
source ssh/bin/activate
pip install -r requirements.txt
python main.py
deactivate
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
    cd /opt/serverchef/init-scripts
    cp confs/nginx/serverchef.local /etc/nginx/sites-available/
    ln -s /etc/nginx/sites-available/serverchef.local /etc/nginx/sites-enabled/serverchef.local
    systemctl restart nginx
fi


systemctl restart supervisord.service

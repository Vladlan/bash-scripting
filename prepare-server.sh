#!/usr/bin/env bash
WWW_FOLDER_PATH=/var/www/
APP_FOLDER_PATH=/var/app/

createFolderIfNotExist() {
	if [ -d "$1" ] 
	then
    	echo "Directory $1 exists." 
	else
    	echo "Directory $1 does not exists. Creating it..."
        sudo mkdir "$1"
        sudo chmod 777 "$1"
	fi
}

createFolderIfNotExist "$WWW_FOLDER_PATH"
createFolderIfNotExist "$APP_FOLDER_PATH"


# cd ~
# curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
# sudo bash /tmp/nodesource_setup.sh
# sudo apt install nodejs
# node -v
#!/bin/bash
# Please note that this script will install the italian version of wordpress. You can change that at line 21

if [ $# -eq 0 ]; then
    echo "Please specify the folder name where you want to install wordpress"
    exit 1
fi
mkdir $1
cd $1

function getPlugin {
    echo " ... installing $1 ... "
    sudo wget -q -O plugin.zip https://downloads.wordpress.org/plugin/$1.zip
    sudo unzip -qq plugin.zip -d "wp-content/plugins"
    sudo rm plugin.zip
}

OWNER=$(ls -ld | awk '{print $3}' | tail -1);

echo "Installing wordpress..."
sudo wget -q -O wordpress.tar.gz https://it.wordpress.org/wordpress-latest-it_IT.tar.gz
sudo tar xfz wordpress.tar.gz
sudo mv wordpress/* ./
sudo rm -rf wordpress
sudo rm wordpress.tar.gz

echo "Installing plugins..."
getPlugin wordpress-seo
getPlugin better-wp-security
getPlugin automatic-updater
getPlugin wp-fastest-cache

echo "Cleaning unused themes / plugins..."
sudo rm wp-content/plugins/hello.php
sudo rm -rf wp-content/themes/twentyfifteen/
sudo rm -rf wp-content/themes/twentysixteen/
sudo rm -rf wp-content/themes/twentyseventeen/
sudo rm -rf wp-content/themes/twentynineteen/
sudo rm -rf wp-content/themes/twentytwenty/

sudo chown -R $OWNER:$OWNER ./
echo "DONE!!"

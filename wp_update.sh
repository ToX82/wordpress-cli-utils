#!/bin/bash
# Please note that you need wp-cli
# This script will update all wordpress instances (subfolders), starting from the current folder.

echo "Updating wp-cli to its latest version..."
sudo wp cli update

echo ""
DIRS=`find . -name "wp-login.php"`
for d in $(dirname $DIRS) ; do
    echo ""
    echo "Entering $d..."
    user=$(stat -c '%U' $d)
    cd $d
    sudo -u $user wp core update
    sudo -u $user wp plugin update --all
    sudo -u $user wp theme update --all
    cd ..
done

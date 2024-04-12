#!/bin/bash

# Disable def.conf site
a2dissite /etc/apache2/sites-available/def.conf
systemctl reload apache2

# Get the current working directory
cwd=$(pwd)

# Change to the deployment root directory
cd /opt/codedeploy-agent/deployment-root/

# Find all .conf files in the current directory and its subdirectories
conf_files=$(find . -name "def.conf")

# Iterate over the .conf files and enable them
for conf_file in $conf_files; do
   a2ensite "$conf_file"
done

# Reload Apache to apply changes
systemctl reload apache2

# Change back to the original working directory
cd "$cwd"

# Restart Apache
sudo service apache2 restart

#!/bin/sh


echo "Installing ssh-tunnel"

echo "Note that you must have already setup passwordless ssh access to the remote host."

read -p "What user will be used for the tunnel? " user

read -p "What host do you want to connect into? " host

read -p "What port do you want to connect into this host with from $host? " port




echo "Installing Pre-reqs"
apt-get install autossh -y

echo "Installing ssh-tunnel"
mkdir /etc/ssh-tunnel
cp connect /etc/ssh-tunnel/
chmod +x /etc/ssh-tunnel/connect

echo "Configuring tunnel to run at startup"
line="/etc/ssh-tunnel/connect $user@$host $port"
(crontab -u $user -l; echo "$line" ) | crontab -u $user -


echo "Starting tunnel now."
$line


echo "TODO:  You may run this installer multiple times for different hosts."
echo "Examine the startup commands by running 'crontab -e'."

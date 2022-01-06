#!/bin/bash

# Check Privileges

if [ $(whoami) != 'root' ]; then
  echo "Please run with sudo privileges"
  exit 0
else


echo "Uninstall AirConnect..."

systemctl stop airconnect
systemctl disable airconnect

rm -rf /var/lib/airconnect

rm /etc/systemd/system/airconnect.service 

fi


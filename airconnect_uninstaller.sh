#!/bin/bash

# Check Privileges

if [ $(whoami) != 'root' ]; then
  echo "Please run with sudo privileges"
  exit 0


elif [ -d /var/lib/airconnect ]; then

echo "Uninstall AirConnect..."

systemctl stop airconnect
systemctl disable airconnect

rm -rf /var/lib/airconnect

rm /etc/systemd/system/airconnect.service 

rm /var/log/airupnp.log


else
	
echo "AirConnect has already been uninstalled."
echo "For reinstallation use the installer script."
exit 0

fi


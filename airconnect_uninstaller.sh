#!/bin/bash

# Check Privileges

if [ $(whoami) != 'root' ]; then
  echo "Please run with sudo privileges"
  exit 0


# Check OS

OS=$(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release)

elif [ $OS == "raspbian" ]; then


elif [ -d /var/lib/airconnect ]; then

echo "Uninstall AirConnect..."

systemctl disable --now airconnect

rm -rf /var/lib/airconnect

rm /etc/systemd/system/airconnect.service 

rm /var/log/airupnp.log


else
	
echo "AirConnect has already been uninstalled."
echo "For reinstallation use the installer script."
exit 0

fi

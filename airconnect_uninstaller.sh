#!/bin/bash

# Check Privileges

if [ $(whoami) != 'root' ]; then
  echo "Please run with sudo privileges"
  exit 0

elif [ -d /var/lib/airconnect ]; then

  echo "Uninstall AirConnect..."

  systemctl disable --now airupnp

  rm -rf /var/lib/airconnect

  rm /etc/systemd/system/airupnp.service 

else
	
  echo "AirConnect has already been uninstalled."
  echo "For reinstallation use the installer script."
  exit 0

fi

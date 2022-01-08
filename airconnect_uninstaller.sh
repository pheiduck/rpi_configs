#!/bin/bash

# Check Privileges

if [ $(whoami) != 'root' ]; then
  echo "Please run with sudo privileges"
  exit 0


# Declare Variables

proj="AirConnect"
log="airupnp"
pkgname="airconnect"


elif [ -d /var/lib/$pkgname ]; then

echo "Uninstall $proj..."

systemctl disable --now $pkgname 

rm -rf /var/lib/$pkgname

rm /etc/systemd/system/$pkgname.service 

rm /var/log/$log.log


else
	
echo "$proj has already been uninstalled."
echo "For reinstallation use the installer script."
exit 0

fi

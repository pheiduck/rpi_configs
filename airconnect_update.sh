#!/bin/bash

# Check Privileges

if [ $(whoami) != 'root' ]; then
  echo "Please run with sudo privileges"
  exit 0
else


# Update AirConnect

cd /var/lib/airconnect
wget https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-arm
rm airupnp-arm
mv airupnp-arm.* airupnp-arm
chmod 755 airupnp-arm

systemctl restart airconnect

systemctl status airconnect

fi


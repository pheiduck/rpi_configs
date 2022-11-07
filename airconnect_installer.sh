#!/bin/bash

# Check Privileges

if [ $(whoami) != 'root' ]; then
  echo "Please run with sudo privileges"
  exit 0

# Check OS

elif [ $(awk -F= '$1=="ID" { print $2 ;}' /etc/os-release) != 'raspbian' ]; then
  echo "You are trying to install this on an unsupported distribution."
  echo "Only the Raspberry Pi OS is supported."
  exit 0

elif [ -d /var/lib/airconnect ]; then
  GREEN='\033[1;32m'
  echo "${GREEN}Update AirConnect..."

  cd /var/lib/airconnect
  rm -f *
  curl https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-linux-arm -o airupnp-arm
  chmod 755 airupnp-arm
  
  systemctl daemon-reload
  
  systemctl restart airupnp

  systemctl status airupnp

else

  GREEN='\033[0;32m'
  echo "${GREEN}Install AirConnect..."

  mkdir /var/lib/airconnect
  cd /var/lib/airconnect
  curl https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-linux-arm -o airupnp-arm
  chmod 755 airupnp-arm

  cd /etc/systemd/system/
  cat > airupnp.service <<EOF
  [Unit]
  Description=AirUPnP bridge
  After=network-online.target
  Wants=network-online.target

  [Service]
  ExecStart=/var/lib/airconnect/airupnp-arm -l 1000:2000 -Z -x /var/lib/airconnect/airupnp.xml
  Restart=on-failure
  RestartSec=30

  [Install]
  WantedBy=multi-user.target
EOF

  cd /var/lib/airconnect

  systemctl enable --now airupnp

  systemctl status airupnp

fi

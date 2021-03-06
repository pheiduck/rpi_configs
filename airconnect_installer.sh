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

  echo "Update AirConnect..."

  cd /var/lib/airconnect
  curl -O https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-arm
  chmod 755 airupnp-arm
  
  systemctl daemon-reload
  
  systemctl restart airconnect

  systemctl status airconnect


else

  echo "Install AirConnect..."

  mkdir /var/lib/airconnect
  cd /var/lib/airconnect
  curl -O https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-arm
  chmod 755 airupnp-arm

  cd /etc/systemd/system/
  cat > airconnect.service <<EOF
  [Unit]
  Description=AirUPnP bridge
  After=network-online.target
  Wants=network-online.target

  [Service]
  Type=forking
  ExecStart=/var/lib/airconnect/airupnp-arm -l 1000:2000 -z -f /var/log/airupnp.log
  Restart=on-failure
  RestartSec=30

  [Install]
  WantedBy=multi-user.target
EOF

  cd /var/lib/airconnect

  systemctl enable --now airconnect

  systemctl status airconnect

fi

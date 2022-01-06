#!/bin/bash

# Check Privileges

if [ $(whoami) != 'root' ]; then
  echo "Please run with sudo privileges"
  exit 0
else


# Install AirConnect

mkdir /var/lib/airconnect
cd /var/lib/airconnect
wget https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-arm
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

systemctl enable airconnect.service
systemctl start airconnect.service

service airconnect status

fi


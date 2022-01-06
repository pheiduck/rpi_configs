#!/bin/bash

# Check Privileges

if [ $(whoami) != 'root' ]; then
  echo "Please run with sudo privileges"
  exit 0


elif [ $(cd /var/lib/airconnect) != -f "airupnp-arm" ]; then

echo "Install AirConnect..."

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

systemctl enable airconnect
systemctl start airconnect

systemctl status airconnect


else

echo "Update AirConnect..."

cd /var/lib/airconnect
rm airupnp-arm
wget https://raw.githubusercontent.com/philippe44/AirConnect/master/bin/airupnp-arm
chmod 755 airupnp-arm

systemctl restart airconnect

systemctl status airconnect

fi

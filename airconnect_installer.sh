#!/bin/bash

# Check Privileges

if [ $(whoami) != 'root' ]; then
  echo "Please run with sudo privileges"
  exit 0


# Declare Variables

proj="AirConnect"
pkg="airupnp-arm"
log="airupnp"
pkgname="airconnect"
src="https://raw.githubusercontent.com/philippe44/$proj/master/bin/$pkg"


elif [ -d /var/lib/$pkgname ]; then

echo "Update $proj..."

cd /var/lib/$pkgname
rm $pkg
curl $src -o $pkg
chmod 755 $pkg

systemctl restart $pkgname

systemctl status $pkgname


else

echo "Install $proj..."

mkdir /var/lib/$pkgname
cd /var/lib/$pkgname
curl $src -o $pkg
chmod 755 $pkg

cd /etc/systemd/system/
cat > $pkgname.service <<EOF
[Unit]
Description=AirUPnP bridge
After=network-online.target
Wants=network-online.target

[Service]
Type=forking
ExecStart=/var/lib/$pkgname/$pkg -l 1000:2000 -z -f /var/log/$log.log
Restart=on-failure
RestartSec=30

[Install]
WantedBy=multi-user.target
EOF

cd /var/lib/$pkgname

systemctl enable --now $pkgname

systemctl status $pkgname 

fi

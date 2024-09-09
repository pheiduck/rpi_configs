#!/usr/bin/env sh

# Aktualisiere das System
echo "Aktualisiere das System..."
sudo apt update && sudo apt dist-upgrade -y

# Installiere Pi-hole
echo "Installiere Pi-hole..."
curl -sSL https://install.pi-hole.net | bash

# Füge die Cloudflare GPG Schlüssel für cloudflared hinzu
echo "Füge Cloudflared gpg key hinzu..."
sudo mkdir -p --mode=0755 /usr/share/keyrings
curl -fsSL https://pkg.cloudflare.com/cloudflare-main.gpg | sudo tee /usr/share/keyrings/cloudflare-main.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/cloudflared $(lsb_release -cs) main' | sudo tee /etc/apt/sources.list.d/cloudflared.list

# Aktualisiere die Paketquellen und installiere cloudflared
echo "Installiere cloudflared..."
sudo apt update
sudo apt install -y cloudflared

# Verifiziere die Installation von cloudflared
echo "Verifiziere cloudflared Version..."
cloudflared -v

# Erstelle cloudflared Konfigurationsoptionen in /etc/default/cloudflared
echo "Konfiguriere /etc/default/cloudflared..."
sudo tee /etc/default/cloudflared > /dev/null << EOL
# Cloudflared Optionen für DNS-over-HTTPS
CLOUDFLARED_OPTS="--port 5053 --max-upstream-conns 50 --upstream https://1.1.1.1/dns-query --upstream https://1.0.0.1/dns-query --upstream https://1.1.1.2/dns-query --upstream https://1.0.0.2/dns-query --upstream https://1.1.1.3/dns-query --upstream https://1.0.0.3/dns-query --upstream https://8.8.8.8/dns-query --upstream https://8.8.4.4/dns-query"
EOL

# Konfiguriere den cloudflared Dienst gemäß deinen Vorgaben
echo "Konfiguriere cloudflared Dienst..."
sudo tee /etc/systemd/system/cloudflared.service > /dev/null << EOL
[Unit]
Description=cloudflared DNS over HTTPS proxy
After=syslog.target network-online.target

[Service]
Type=simple
User=cloudflared
EnvironmentFile=/etc/default/cloudflared
ExecStart=/usr/local/bin/cloudflared proxy-dns $CLOUDFLARED_OPTS
Restart=on-failure
RestartSec=10
KillMode=process

[Install]
WantedBy=multi-user.target
EOL

# Starte und aktiviere den cloudflared Dienst
echo "Starte und aktiviere cloudflared..."
sudo systemctl daemon-reload
sudo systemctl enable cloudflared
sudo systemctl start cloudflared

# Konfiguriere Pi-hole, um cloudflared als Upstream-DNS zu verwenden
echo "Konfiguriere Pi-hole mit cloudflared DNS..."
sudo sed -i 's/^PIHOLE_DNS_1.*/PIHOLE_DNS_1=127.0.0.1#5053/' /etc/pihole/setupVars.conf
sudo sed -i 's/^PIHOLE_DNS_2.*/PIHOLE_DNS_2=127.0.0.1#5053/' /etc/pihole/setupVars.conf

# Starte Pi-hole neu, um die Änderungen zu übernehmen
echo "Starte Pi-hole neu..."
pihole restartdns

# Alles erledigt
echo "Pi-hole und cloudflared sind erfolgreich installiert!"

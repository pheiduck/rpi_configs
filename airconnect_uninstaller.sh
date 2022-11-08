#!/bin/zsh

# Check Privileges

if [ $(whoami) != 'root' ]; then
  YELLOW='\033[1;33m'
  NC='\033[0m'
  echo "${YELLOW}Please run with sudo privileges${NC}"
  exit 0

elif [ -d /var/lib/airconnect ]; then
  RED='\033[0;31m'
  NC='\033[0m'
  echo "${RED}Uninstall AirConnect...${NC}"

  systemctl disable --now airupnp

  rm -rf /var/lib/airconnect

  rm /etc/systemd/system/airupnp.service 

else
  YELLOW='\033[0;33m'
  NC='\033[0m'
  echo "${YELLOW}AirConnect has already been uninstalled."
  echo "For reinstallation use the installer script.${NC}"
  exit 0

fi

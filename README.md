# rpi_configs

Basic config changes on inital setup of my Raspberry Pi's
- Provides -

## Configs
- zshrc (user and root)
- cmdline.txt (configs for 3.5 LCD)
- hosts.allow (only allow connections from local and vpn network)
- hosts.deny (deny all other hosts)
- sshd_config (Basic changes: Port, Limited Sessions; Retries Only connection with ssh-key)

## Install Scripts
- airconnect_installer.sh (Installes AirConnect, to get AirPlay on Sonos Products which doesn't have it builtin)
- airconnect_update.sh (Update AirConnect)
- airconnect_uninstaller.sh (Uninstall AirConnect)

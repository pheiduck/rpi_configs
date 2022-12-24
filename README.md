# rpi_configs

Basic config changes on inital setup of my Raspberry Pi's

## Configs
- zshrc (user / Pihole Chronometer Setup)
- cmdline.txt (configs for 3.5 LCD)
- hosts.allow (only allow connections from local and vpn network)
- hosts.deny (deny all other hosts)
- sshd_config (Port, Limited Sessions; Retries Only connection with ssh-key)
- systemd service / timer to renew ssl certificate (smallstep)
- nginx conf for pihole

## Scripts
- airconnect_installer.sh (Installes AirConnect, to get AirPlay on Sonos Products which doesn't have it builtin.
  Updating AirConnect if exists on the System.)
- airconnect_uninstaller.sh (Uninstall AirConnect)

## Downloads

# airconnect_installer.sh:
```
curl -sSL https://raw.githubusercontent.com/pheiduck/rpi_configs/main/airconnect_installer.sh | zsh
```
#  airconnect print logs:
```
journalctl -u airupnp.service -f
```
# airconnect_uninstaller.sh:
```
curl -sSL https://raw.githubusercontent.com/pheiduck/rpi_configs/main/airconnect_uninstaller.sh | zsh
```

## ToDo's

- Make a Script for inital setup, with User interactions

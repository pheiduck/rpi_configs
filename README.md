# rpi_configs


Basic config changes on initial setup of my Raspberry Pi's

## Configs
- zshrc (user / Pihole Chronometer Setup)
- cmdline.txt (configs for 3.5 LCD)
- hosts.allow (only allow connections from local and vpn network)
- hosts.deny (deny all other hosts)
- sshd_config (Port, Limited Sessions; Retries Only connection with ssh-key)
- systemd service / timer to renew ssl certificate (smallstep)
- nginx conf for pihole

## Scripts
- airconnect_installer (Install <a href="https://github.com/philippe44/AirConnect">AirConnect</a>, to get AirPlay on Sonos Products which doesn't have it builtin.
  Updating <a href="https://github.com/philippe44/AirConnect">AirConnect</a> if exists on the System.)
- airconnect_uninstaller (Uninstall <a href="https://github.com/philippe44/AirConnect">AirConnect</a>)
- YT: <a href="https://www.youtube.com/embed/LFh8p6sSCow?start=9&end=167">Video</a>
## Downloads
#### airconnect_installer supports Linux w/ systemd only.

Are you using bash?: https://github.com/pheiduck/rpi_configs/issues/10#issuecomment-1519088347

# airconnect_installer:

```
curl -sSL https://raw.githubusercontent.com/pheiduck/rpi_configs/main/airconnect/airconnect_installer | zsh
```
#### For Update run the Install Script again.

# airconnect_uninstaller:
```
curl -sSL https://raw.githubusercontent.com/pheiduck/rpi_configs/main/airconnect/airconnect_uninstaller | zsh
```
# airconnect print logs:
```
journalctl -u airupnp.service -f
```

# pihole-cloudflared
```
curl -sSL https://raw.githubusercontent.com/pheiduck/rpi_configs/main/pihole-cloudflared | zsh
```
# update_fastfetch

```
curl -sSL https://raw.githubusercontent.com/pheiduck/rpi_configs/main/update_fastfetch | zsh
```

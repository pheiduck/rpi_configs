...
# Start Pi-hole chrono when on tty1
case $(tty) in /dev/tty1)
  msg="Starting Pi-hole chronometer ... "
  row=2
  col=2
  clear
  tput cup $row $col
  echo -n "$msg"
  l=${#msg}
  let l=l+col
  for i in {3..1}
  do
    tput cup $row $l
    echo -n "$i"
    sleep 1
  done
  clear
  pihole -c
  exit 0
esac
neofetch

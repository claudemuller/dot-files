#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

host=$(hostname)

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

for m in $(polybar --list-monitors | cut -d":" -f1); do
	#if [ "$m" == "HDMI-0" ]; then
		export TRAY_POS=right
	#fi

    if [[ "$host" == "samurai" ]]
    then
        WIRELESS=$(ls /sys/class/net/ | grep ^wl | awk 'NR==1{print $1}') MONITOR=$m polybar --reload mainbar-bspwm &
    else
        WIRELESS=$(ls /sys/class/net/ | grep ^wl | awk 'NR==1{print $1}') MONITOR=$m polybar -c /home/dief/.config/polybar/config.shinobi --reload mainbar-bspwm &
    fi
done

echo "Bars launched..."

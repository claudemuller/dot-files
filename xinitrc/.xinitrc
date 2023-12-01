#!/usr/bin/env sh

#xautolock -time 10 -locker /home/dief/.local/bin/lock &
#xbindkeys
#~/.config/wpg/wp_init.sh

[ -f ~/.xprofile ] && . ~/.xprofile

/home/lukefilewalker/.local/bin/keyboard &
file-inotify /tmp/keyboard.lock /home/lukefilewalker/.local/bin/keyboard &  # Triggered by udev rule

#exec dwm
exec bspwm 

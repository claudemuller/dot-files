#!/usr/bin/env sh

xautolock -time 10 -locker /home/dief/.local/bin/lock &
xbindkeys
~/.config/wpg/wp_init.sh

[ -f ~/.xprofile ] && . ~/.xprofile

exec dwm

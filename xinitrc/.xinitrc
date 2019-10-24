#!/usr/bin/env sh

xautolock -time 10 -locker /home/dief/.local/bin/lock &
xbindkeys

[ -f ~/.xprofile ] && . ~/.xprofile

exec dwm

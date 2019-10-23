#!/usr/bin/env sh

setxkbmap -option caps:backspace
setxkbmap -option compose:ralt
xautolock -time 10 -locker /home/dief/.local/bin/lock &

source ~/.profile

exec dwm

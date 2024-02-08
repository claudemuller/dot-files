#!/usr/bin/env bash

if [ -x "$(command -v dunst)" ]; then
	pkill dunst
	dunst -config $HOME/.config/leftwm/themes/current/conf/dunst.config &
fi

if [ -x "$(command -v picom)" ]; then
	picom --config $HOME/.config/leftwm/themes/current/conf/picom.config &>/dev/null &
fi

if [ -x "$(command -v feh)" ]; then
	feh --bg-fill "$HOME"/.config/leftwm/themes/current/wallpaper.png
fi

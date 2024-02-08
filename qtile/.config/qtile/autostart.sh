#!/usr/bin/env bash

if [ -x "$(command -v dunst)" ]; then
	pkill dunst
	dunst -config $HOME/.config/qtile/conf/dunst.config &
fi

if [ -x "$(command -v picom)" ]; then
	picom --config $HOME/.config/qtile/conf/picom.config &>/dev/null &
fi

if [ -x "$(command -v feh)" ]; then
	feh --bg-fill "$HOME"/.config/qtile/wallpaper.png
fi

if [ -x "$(command -v nm-applet)" ]; then
	pkill nm-applet
	nm-applet &
fi

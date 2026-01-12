#!/usr/bin/env bash

# This was needed when not using polkitd in manjaro
# /usr/lib/polkit-kde-authentication-agent-1 &	# Graphical authentication agent

if [ -x "$(command -v dunst)" ]; then
	pkill dunst
	dunst -config $HOME/.config/qtile/conf/dunst.config &
fi

#if [ -x "$(command -v picom)" ]; then
#	sleep 1
#	picom --config $HOME/.config/qtile/conf/picom.config &>/dev/null &
#fi

if [ -x "$(command -v feh)" ]; then
	feh --bg-fill "$HOME"/Pictures/wallpapers/wallhaven-39gpe9.jpg
fi

if [ -x "$(command -v nm-applet)" ]; then
	pkill nm-applet
	nm-applet &
fi

if [ -x "$(command -v greenclip)" ]; then
	pkill greenclip
	greenclip daemon &
fi

if [ -x "$(command -v nextcloud)" ]; then
	pkill nextcloud
	nextcloud --background &
fi

# Set us kb layout
$HOME/.local/bin/kb-layout-switcher

# If the Thinkpad laptop
if [[ "$(uname -n)" == "loki" ]]; then
	# Set dvorak layout for kb
	$HOME/.local/bin/kb-layout-switcher dvorak

	# Disable touchpad
	xinput set-prop 'ELAN0676:00 04F3:3195 Touchpad' 'Device Enabled' 0

	# Running audio
	if [ -x "$(command -v pipewire)" ]; then
		killall pipewire
		pipewire &
	fi
	if [ -x "$(command -v wireplumber)" ]; then
		killall wireplumber
		wireplumber &
	fi

if [ -x "$(command -v autorandr)" ]; then
	autorandr --change
fi

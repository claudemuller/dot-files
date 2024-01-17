#!/usr/bin/env bash

# SETTINGS ####################################################
# Possible positions:
# center
# north
# northeast
# east
# southeast
# south
# southwest
# west
# northwest
LOCATION="center"
###############################################################

LPATH="$(
	cd "$(dirname "$0")"
	pwd -P
)"

# Rofi config
rofi_cmd="rofi -theme $LPATH/rasi/launcher-tabbed.rasi"

# Main
# $rofi_cmd -no-lazy-grab -show drun -modi drun \
# 	-theme-str 'window {location: '$LOCATION';}'

$rofi_cmd -no-lazy-grab -show drun \
	-kb-custom-1 'Control+1' \
	-kb-custom-2 'Control+2' \
	-kb-custom-3 'Control+3' \
	-kb-custom-4 'Control+4'


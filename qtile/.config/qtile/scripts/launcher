#!/usr/bin/env bash

LPATH="$(
	cd "$(dirname "$0")"
	pwd -P
)"

rofi_cmd="rofi -theme $LPATH/rasi/launcher-tabbed.rasi"

$rofi_cmd -no-lazy-grab -show drun \
	-kb-custom-1 'Control+1' \
	-kb-custom-2 'Control+2' \
	-kb-custom-3 'Control+3' \
	-kb-custom-4 'Control+4'

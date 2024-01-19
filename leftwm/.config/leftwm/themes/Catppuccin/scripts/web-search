#!/usr/bin/env bash

LPATH="$(
	cd "$(dirname "$0")"
	pwd -P
)"

browser="firefox"
rofi_cmd="rofi -theme $LPATH/rasi/base.rasi"

# The first option will be the default
sengines=("duckduckgo" "brave" "google")
engines=$(printf "%s\n" "${sengines[@]}")

engine=$(echo -e "$engines" | $rofi_cmd -dmenu -theme-str 'listview {lines: 3;}' -p "Search engine:")
input_string=$($rofi_cmd -dmenu -theme-str 'listview {enabled: false;}' -p "Search for:")

if [ -n "$input_string" ]; then
	case $engine in
	google)
		$browser -new-tab "https://google.com/search?q=$input_string"
		;;

	brave)
		$browser -new-tab "https://search.brave.com/search?q=$input_string"
		;;

	*)
		$browser -new-tab "https://$engine.com/?q=$input_string"
		;;
	esac
fi

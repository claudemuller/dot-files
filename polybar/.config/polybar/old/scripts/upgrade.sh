#!/usr/bin/env bash

upgrade=$(apt list --upgradable |& grep -Ev '^(Listing|WARNING)')

if [ -n "$upgrade" ]; then
    no_of_updates=$(apt list --upgradeable | wc -l)
    echo "$no_of_updates Updates"
else
    echo "No updates"
fi

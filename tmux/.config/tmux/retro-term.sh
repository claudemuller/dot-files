#!/usr/bin/env bash

palette=${1:-base}

if [ "$palette" = "base" ]; then
    tmux set -g status-style "bg=#120f09,fg=#8a704e"
    tmux set -g status-left-style "bg=#1e1812,fg=#c09048"
    tmux set -g status-right-style "bg=#1e1812,fg=#c09048"
    tmux set -g window-status-current-style "bg=#d8a860,fg=#120f09,bold"
    tmux set -g window-status-style "bg=#1e1812,fg=#8a704e"
    tmux set -g pane-border-style "fg=#5a4632"
    tmux set -g pane-active-border-style "fg=#d8a860"
    tmux set -g message-style "bg=#2a2018,fg=#c09048"
    tmux set -g message-command-style "bg=#2a2018,fg=#c09048"
    tmux set -g mode-style "bg=#d8a860,fg=#120f09,bold"

elif [ "$palette" = "muted" ]; then
    tmux set -g status-style "bg=#120f09,fg=#a28662"
    tmux set -g status-left-style "bg=#1e1812,fg=#c0a179"
    tmux set -g status-right-style "bg=#1e1812,fg=#c0a179"
    tmux set -g window-status-current-style "bg=#d6b891,fg=#120f09,bold"
    tmux set -g window-status-style "bg=#1e1812,fg=#a28662"
    tmux set -g pane-border-style "fg=#66553f"
    tmux set -g pane-active-border-style "fg=#d6b891"
    tmux set -g message-style "bg=#35291d,fg=#c0a179"
    tmux set -g message-command-style "bg=#35291d,fg=#c0a179"
    tmux set -g mode-style "bg=#c0a179,fg=#120f09,bold"

elif [ "$palette" = "original" ]; then
    tmux set -g status-style "bg=#000000,fg=#996600"
    tmux set -g status-left-style "bg=#1a0f00,fg=#ffb000"
    tmux set -g status-right-style "bg=#1a0f00,fg=#ffb000"
    tmux set -g window-status-current-style "bg=#ffc040,fg=#000000,bold"
    tmux set -g window-status-style "bg=#1a0f00,fg=#996600"
    tmux set -g pane-border-style "fg=#664400"
    tmux set -g pane-active-border-style "fg=#ffc040"
    tmux set -g message-style "bg=#332000,fg=#ffb000"
    tmux set -g message-command-style "bg=#332000,fg=#ffb000"
    tmux set -g mode-style "bg=#ffc040,fg=#000000,bold"
fi

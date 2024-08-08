#!/usr/bin/env zsh

# --------------------------------------------------------------------------------------- XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# --------------------------------------------------------------------------------------------- Zsh
export ZDOTDIR=$HOME/.config/zsh
export HISTFILE="$XDG_DATA_HOME"/zsh/history
export HISTSIZE=1000000
export SAVEHIST=1000000

# ------------------------------------------------------------------------------------------- Paths
if [ -d "$HOME/go" ]; then
  export GOPATH=$HOME/go
  export GOBIN=$GOPATH/bin
  PATH="$(go env GOPATH)/bin:$PATH"
fi

if [ -d "$HOME/.luarocks/bin" ]; then
  PATH="$HOME/.luarocks/bin:$PATH"
fi

if [ -d "$HOME/.bin" ]; then 
  PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ]; then
  PATH="$HOME/Applications:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
  PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.yarn/bin" ]; then
  PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -d "$HOME/.yarn/bin" ]; then
  PATH="/opt/clang-format-static:$PATH"
fi

export PATH=$PATH

# --------------------------------------------------------------------------------------------- Env
export BROWSER="brave"
export VISUAL="nvim"
export EDITOR="nvim"
export TERMINAL="kitty"

export MANPAGER='nvim +Man!'
# export MANPAGER="sh -c 'col -bx | bat --theme=\"base16-256\" -l man -p'"
export MANWIDTH=999

export TERM="xterm-256color"
# export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export EDITOR="nvim"
export VISUAL="nvim"

# SSH Agent stuff
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# eval "`pip completion --zsh`"

# fzf
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree"

FZF_COLORS="bg+:-1,\
fg:gray,\
fg+:white,\
border:black,\
spinner:0,\
hl:yellow,\
header:blue,\
info:green,\
pointer:red,\
marker:blue,\
prompt:gray,\
hl+:red"

export FZF_DEFAULT_OPTS="--height 60% \
--border sharp \
--layout reverse \
--color '$FZF_COLORS' \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n 10'"

case "$(uname -s)" in
Darwin)
    export GOARCH=arm64
	;;

Linux)
	;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
	# 'MS Windows'
	;;
*)
	# 'Other OS'
	;;
esac

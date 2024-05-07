# --------------------------------------------------------------------------------------- XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# --------------------------------------------------------------------------------------------- Zsh
export ZDOTDIR=$HOME/.config/zsh

# -----------------------------------------------------------------------------------------The rest
export QT_QPA_PLATFORMTHEME="qt5ct"
export EDITOR=/usr/bin/nvim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_THEME=Catppuccin-Mocha-Standard-Mauve-Dark
. "$HOME/.cargo/env"

# Added by Toolbox App
export PATH="$PATH:/home/claude/.local/share/JetBrains/Toolbox/scripts"

hostname=$(uname -n)

case $hostname in
shinobi)
	export BROWSER=firefox
	;;

claude)
	export BROWSER=brave
	;;

*) ;;
esac

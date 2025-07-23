
if [ -d "$HOME/go" ]; then
  export GOPATH=$HOME/go
  export GOBIN=$GOPATH/bin
  PATH="$(whereis go):$(go env GOPATH)/bin:$PATH"
fi

if [ -d "$HOME/.luarocks/bin" ]; then
  PATH="$HOME/.luarocks/bin:$PATH"
fi

if [ -d "$HOME/.bin" ]; then 
  PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/apps" ]; then 
  PATH="$HOME/apps:$PATH"
fi

if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ]; then
  PATH="$HOME/Applications:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ]; then
  PATH="$HOME/.cargo/bin:$PATH"
	. "$HOME/.cargo/env"
fi

if [ -d "$HOME/.yarn/bin" ]; then
  PATH="$HOME/.yarn/bin:$PATH"
fi

if [ -d "$HOME/.deno/bin" ]; then
    . "$HOME/.deno/env"
fi

export PATH=$PATH

# --------------------------------------------------------------------------------------------- Env
export BROWSER="brave"
export VISUAL="/usr/bin/nvim"
export EDITOR=/usr/bin/nvim
export TERMINAL="wezterm"

export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export GTK_THEME=Catppuccin-Mocha-Standard-Mauve-Dark

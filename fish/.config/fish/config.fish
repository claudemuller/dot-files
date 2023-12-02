if status is-interactive
  fish_vi_key_bindings

  set -g fish_greeting
  set -g theme_nerd_fonts yes

  #################################################################################################
  # Aliases
  alias ls='ls --color=auto'
  alias l='ls -lah'
  alias lt='ls -latr'

  alias vim=nvim
  alias v=nvim
  alias bat='bat --theme="Catppuccin-macchiato"'

  alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

  #################################################################################################
  # Variables
  if [ $(hostname) = "shinobi" ]
    export BROWSER=firefox
  else
    export BROWSER=brave
  end

  #################################################################################################
  # Exports
  export GOPATH="$HOME/go"
  export EDITOR="nvim"
  export VISUAL="nvim"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export HELIX_RUNTIME=$HOME/repos/3rd-party/helix/runtime

  set -x PATH $PATH "$GOPATH/bin"
  set -x PATH $PATH "$HOME/yarn/.bin"
  set -x PATH $PATH "/opt/clang-format-static"

  #################################################################################################
  # Misc
  neofetch

  /usr/bin/rtx activate fish | source
end

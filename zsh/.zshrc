# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
IS_MAC=$(uname)

setopt appendhistory nomatch notify
unsetopt autocd beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# Colours
if [[ "$IS_MAC" != "Darwin" ]]; then
    (cat ~/.config/wpg/sequences &)
fi
#xrdb -load ~/.Xresources &

# Autosuggestions
if [[ "$IS_MAC" == "Darwin" ]]; then
    source /usr/local/Cellar/zsh-autosuggestions/0.6.4/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Prompt
export PS1="[%n@%m %c]$ "

# Git in prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# Use vi mode
bindkey -v

# Vi mode settings
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Easier, more vim-like editor opening
# `v` is already mapped to visual mode, so we need to use a different key to
# open Vim
bindkey -M vicmd "^V" edit-command-line

# Aliases
#alias ls="br -dp"
# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Some vars
export VISUAL=vim;
export EDITOR=vim;

# nvm stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# If logging in to TTY after boot start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi

export PATH=$PATH:$HOME/.config/composer/vendor/bin
export NOTES_DIR=$HOME/repos/notes

alias tsm='transmission-remote'
alias dls='watch -n 5 "transmission-remote -tall -l | egrep \"(Downloading|Seeding|Up & Down|Uploading|Idle)\" | sort -k 2 -n -r"'
alias vim='nvim'
alias cp="cp -iv"
if [[ "$IS_MAC" == "Darwin" ]]; then
    alias ls="ls -G"
else
    alias ls="ls --color=tty"
fi

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# zsh Completion
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi
FPATH=$HOME/.zsh/completions:$FPATH
autoload -Uz compinit
rm -f ~/.zcompdump
if [[ "$IS_MAC" == "Darwin" ]]; then
    compinit -i | xargs chmod g-w
else
    zstyle :compinstall filename "$HOME/.zshrc"
fi
compinit

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# System info
neofetch


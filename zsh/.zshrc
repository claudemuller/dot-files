# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory nomatch notify
unsetopt autocd beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dief/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

VISUAL=vim; export VISUAL EDITOR=vim; export EDITOR

neofetch

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

# Load zsh plugins
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
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
zle-up-and-back() {
  zle .up-line-or-history
  #zle .beginning-of-line
}
zle -N zle-up-and-back
bindkey -M vicmd k zle-up-and-back      # k in command mode
bindkey -M vicmd '^[[A' zle-up-and-back # cursor-up key in command mode
bindkey -M viins '^[[A' zle-up-and-back # cursor-up key in insert mode
#bindkey "^[OA" up-line-or-beginning-search
#bindkey -M vicmd "k" up-line-or-beginning-search
zle-down-and-back() {
  zle .down-line-or-history
  #zle .beginning-of-line
}
zle -N zle-down-and-back
bindkey -M vicmd j zle-down-and-back       # j in command mode
bindkey -M vicmd '^[[B' zle-down-and-back  # cursor-down key in command mode
bindkey -M viins '^[[B' zle-down-and-back  # cursor-down key in insert mode
#bindkey "^[OB" down-line-or-beginning-search
#bindkey -M vicmd "j" down-line-or-beginning-search

# Easier, more vim-like editor opening
# `v` is already mapped to visual mode, so we need to use a different key to
# open Vim
bindkey -M vicmd "^V" edit-command-line

# Aliases
# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# Some vars
export VISUAL=vim;
export EDITOR=vim;
export BROWSER=brave;

# nvm stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#export NVM_DIR="$HOME/.nvm"
#  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
#  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# If logging in to TTY after boot start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi

export PATH=$PATH:$HOME/.config/composer/vendor/bin:/home/dief/.gem/ruby/2.7.0:/usr/lib/ruby/gems/2.7.0
export NOTES_DIR=$HOME/repos/notes
export NASA_API_KEY=rMifLvTLpgYfUomy1Iidfjamje0XOY5igAbYoOII

if [[ "$IS_MAC" == "Darwin" ]]; then
    export ANDROID_HOME=/Users/claude/Library/Android/sdk
    export JAVA_HOME=$(/usr/libexec/java_home -v11)
    export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
    export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
    alias java8='export JAVA_HOME=$JAVA_8_HOME'
    alias java11='export JAVA_HOME=$JAVA_11_HOME'
else
    export JAVA_HOME=/usr/lib/jvm/java-14-openjdk
    export _JAVA_AWT_WM_NONREPARENTING=1
fi

alias tsm='transmission-remote-cli'
alias dls='watch -n 5 "transmission-remote-cli -tall -l | egrep \"(Downloading|Seeding|Up & Down|Uploading|Idle)\" | sort -k 2 -n -r"'
alias vim='nvim'
alias cp="cp -iv"
if [[ "$IS_MAC" == "Darwin" ]]; then
    alias ls="ls -G"
else
    alias ls="ls --color=tty"
fi

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

# SSH Agent Stuff
SSH_ENV="$HOME/.ssh/agent-environment"

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

# System info
neofetch

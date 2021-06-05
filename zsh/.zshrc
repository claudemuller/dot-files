if [[ $(uname) == "Darwin" ]]; then
    IS_MAC=true
elif [[ $(lsb_release -si) == "Pop" ]]; then
    IS_POP=true
elif [[ $(hostname) == "daimyo" ]]; then
    IS_DAIMYO=true
fi

if [[ "$IS_POP" == false ]]; then
    #U
    USE_POWERLINE="true"

    # Source manjaro-zsh-configuration
    if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
      source /usr/share/zsh/manjaro-zsh-config
    fi
    # Use manjaro zsh prompt
    if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
      source /usr/share/zsh/manjaro-zsh-prompt
    fi
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory nomatch notify
unsetopt autocd beep extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install

# Colours
if [[ "$IS_MAC" != true && "$IS_DAIMYO" != true ]]; then
    #(cat ~/.config/wpg/sequences &)
else
    # pyenv
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi

    alias python=$HOME/.pyenv/versions/3.9.4/bin/python
fi
#xrdb -load ~/.Xresources &

# Load zsh plugins
if [[ "$IS_MAC" == true ]]; then
    #source /usr/local/Cellar/zsh-autosuggestions/0.6.4/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ "$IS_POP" == true ]]; then
    source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ "$IS_DAIMYO" == true ]]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Prompt
#export PS1="[%n@%m %c]$ "

# Git in prompt
#autoload -Uz vcs_info
#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
#setopt prompt_subst
#RPROMPT=\$vcs_info_msg_0_
#zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
#zstyle ':vcs_info:*' enable git

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
export BROWSER=firefox;

if [[ "$IS_POP" == true ]]; then
    export TERM=xterm-kitty
    export TERMINFO=/usr/lib/kitty/terminfo
fi

if [[ "$IS_DAIMYO" == true ]]; then
    export TERM=ansi
fi

# nvm stuff
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# If logging in to TTY after boot start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi

export PATH=$PATH:$HOME/.config/composer/vendor/bin:$HOME/.gem/ruby/2.7.0:/usr/lib/ruby/gems/2.7.0:$HOME/.local/bin:/usr/local/lib/node_modules/yarn/bin/:$HOME/.yarn/bin

if [[ "$IS_MAC" == true ]]; then
    #export JAVA_HOME=$(/usr/libexec/java_home -v11)
    #export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
    #export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
    #alias java8='export JAVA_HOME=$JAVA_8_HOME'
    #alias java11='export JAVA_HOME=$JAVA_11_HOME'
elif [[ "$IS_POP" == true ]]; then
    # use 'sudo update-java-alternatives --set <jdk_loc>'
    #export JAVA_HOME=/usr/lib/jvm/java-1.14.0-openjdk-amd64
else
    export JAVA_HOME=/usr/lib/jvm/java-14-openjdk
    export _JAVA_AWT_WM_NONREPARENTING=1
    export PATH=$PATH:$HOME/.config/composer/vendor/bin:/home/dief/.gem/ruby/2.7.0:/usr/lib/ruby/gems/2.7.0:$HOME/.local/bin:/usr/local/go/bin
fi

alias pv=protonvpn-cli
alias tsm='transmission-remote-cli'
alias dls='watch -n 5 "transmission-remote-cli -tall -l | egrep \"(Downloading|Seeding|Up & Down|Uploading|Idle)\" | sort -k 2 -n -r"'
alias vim='nvim'
alias cp="cp -iv"
if [[ "$IS_MAC" == true ]]; then
    alias ls="ls -G"
    alias dcl="docker container list"
    alias dcs="docker container start"
    alias dc="docker container"
elif [[ "$IS_POP" == true ]]; then
    alias fd="fdfind"
else
    alias ls="ls --color=tty"
fi

# zsh Completion
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi
if [[ "$IS_DAIMYO" == true ]]; then
    FPATH=/usr/share/zsh/site-functions:$FPATH
else
    FPATH=$HOME/.zsh/completions:$FPATH
fi
autoload -Uz compinit
rm -f ~/.zcompdump
if [[ "$IS_MAC" == true ]]; then
    compinit -i | xargs chmod g-w
else
    zstyle :compinstall filename "$HOME/.zshrc"
fi
compinit

# SSH Agent Stuff
if [[ "$IS_POP" == false ]]; then
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
fi

# Set Spaceship ZSH as a prompt
fpath=( "${ZDOTDIR:-$HOME}/.zfunctions" $fpath )
autoload -U promptinit; promptinit
prompt spaceship
# Prompt
#ZSH_THEME="spaceship"
#SPACESHIP_PROMPT_ADD_NEWLINE="true"
#SPACESHIP_CHAR_PREFIX='\ufbdf '
#SPACESHIP_CHAR_PREFIX_COLOR='yellow'
#SPACESHIP_CHAR_SUFFIX=(" ")
#SPACESHIP_CHAR_COLOR_SUCCESS="yellow"
#SPACESHIP_CHAR_SYMBOL='~'
#SPACESHIP_PROMPT_DEFAULT_PREFIX="$USER"
#SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
#SPACESHIP_VENV_COLOR="magenta"
#SPACESHIP_VENV_PREFIX="("
#SPACESHIP_VENV_SUFFIX=")"
#SPACESHIP_VENV_SYMBOL='\uf985'
#SPACESHIP_USER_SHOW="true"
#SPACESHIP_DOCKER_SYMBOL='\ue7b0'
#SPACESHIP_DOCKER_VERBOSE='false'
#SPACESHIP_BATTERY_SHOW='always'
#SPACESHIP_BATTERY_SYMBOL_DISCHARGING='\uf57d'
#SPACESHIP_BATTERY_SYMBOL_FULL='\uf583'
#SPACESHIP_BATTERY_SYMBOL_CHARGING='\uf588'

#eval "$(starship init zsh)"

if [[ "$IS_MAC" == true ]]; then
    export SDKMAN_DIR="/Users/claudemuller/.sdkman"
    [[ -s "/Users/claudemuller/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/claudemuller/.sdkman/bin/sdkman-init.sh"
fi

# System info
neofetch


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

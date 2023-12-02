if [ "$TERMINAL_EMULATOR" != "JetBrains-JediTerm" ] && [ -z "$TMUX" ]
then
  echo "<d> for default tmux sesh;"
  echo "<s> for special space;"
  echo "or drop to default shell"

  tmux="TERM=xterm-256color tmux"

  ANS=$(bash -c "read -n 1 c; echo \$c")
  if [ "$ANS" = "d" ]
  then
    exec tmux new-session -A -s default
  elif [ "$ANS" = "s" ]
  then
    exec tmux new-session -A -s specialspace
  else
    # nothing
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### ENV CONDITIONS
if [[ $(uname) == "Darwin" ]]; then
	IS_MAC=true
elif [[ $(hostname) == "odin" ]]; then
	IS_ODIN=true
fi

if [ -f ~/.profile ]; then
    source ~/.profile
fi

if [ "$(uname -n)" = "shinobi" ]
then
  export BROWSER=firefox
else
  export BROWSER=brave
fi

export GOPATH=$HOME/go
# export GOPRIVATE="*.is.comhem.com"
# export GONOPROXY="*.is.comhem.com"
# export GONOSUMDB="*.is.comhem.com"
export PATH=$PATH:$(go env GOPATH)/bin
if [[ "$IS_MAC" == true ]]; then
  export GOARCH=arm64
fi

### EXPORT
export TERM="xterm-256color"
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export EDITOR="nvim"
export VISUAL="nvim"

# export TODOIST_API_KEY="$(pass Todoist/API)"

# SSH Agent stuff
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

### "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

### "vim" as manpager
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

### "nvim" as manpager
# export MANPAGER="nvim -c 'set ft=man' -"

# zsh Settings
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory nomatch notify
unsetopt autocd beep extendedglob

### SET VI MODE ###
bindkey -v

# Make Vi mode transitions faster (KEYTIMEOUT is in hundredths of a second)
export KEYTIMEOUT=1

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load zsh plugins
ZSH_AUTO_COMPLETE=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_SYNTAX_HIGHLIGHTING=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_AUTO_SUGGESTIONS=/usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

if [[ "$IS_MAC" == true ]]; then
  ZSH_AUTO_SUGGESTIONS=/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [[ "$IS_ODIN" == true ]]; then
  ZSH_AUTO_SUGGESTIONS=/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
  ZSH_AUTO_SUGGESTIONS=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -f "$ZSH_AUTO_SUGGESTIONS" ]; then
  source "$ZSH_AUTO_SUGGESTIONS"
fi

if [ -f "$ZSH_SYNTAX_HIGHLIGHTING" ]; then
  source "$ZSH_SYNTAX_HIGHLIGHTING"
fi

if [ -f "$ZSH_AUTO_COMPLETE" ]; then
  source "$ZSH_AUTO_COMPLETE"
  # Select all suggestion instead of top on result only
  zstyle ':autocomplete:tab:*' insert-unambiguous yes
  zstyle ':autocomplete:tab:*' widget-style menu-select
  zstyle ':autocomplete:*' min-input 2
  # bindkey $key[Up] up-line-or-history
  # bindkey $key[Down] down-line-or-history
fi

### PATH
if [ -d "$HOME/.luarocks/bin" ] ;
  then PATH="$HOME/.luarocks/bin:$PATH"
fi

if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/Applications" ] ;
  then PATH="$HOME/Applications:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ;
  then PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/.yarn/bin" ] ;
  then PATH="$HOME/.yarn/bin:$PATH"
fi

export PATH=$PATH:/opt/clang-format-static

### CHANGE TITLE OF TERMINALS
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

### Function extract for common file formats ###
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

IFS=$SAVEIFS

### ALIASES ###

# Whereami
alias wami=hostname

# root privileges
alias doas="doas --"

# navigation
up () {
  local d=""
  local limit="$1"

  # Default to limit of 1
  if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
    limit=1
  fi

  for ((i=1;i<=limit;i++)); do
    d="../$d"
  done

  # perform cd. Show error if cd fails
  if ! cd "$d"; then
    echo "Couldn't go up $limit dirs.";
  fi
}

# vim
alias vim=nvim
alias v=nvim

# bat
alias bat='bat --theme="Catppuccin-macchiato"'

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Colorise and enrich ls output
alias ls='ls --color=auto'
alias l='ls -lah'
alias lt='ls -latr'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss -vikeys'
alias vifm='./.config/vifm/scripts/vifmrun'
alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'
alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc -O MOCDir="$XDG_CONFIG_HOME"/moc'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# bare git repo alias for dotfiles
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Unlock LBRY tips
alias tips='lbrynet txo spend --type=support --is_not_my_input --blocking'

# zsh Completion
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh/site-completions:$FPATH
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

# AWS cli completions
#complete -c $(which aws_completer) aws

### Powerlevel10k
if [[ "$IS_MAC" == true ]]; then
  source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
elif [[ "$IS_ODIN" == true ]]; then
  source $HOME/powerlevel10k/powerlevel10k.zsh-theme
else
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(/usr/bin/rtx activate zsh)"

export HELIX_RUNTIME=$HOME/repos/3rd-party/helix/runtime

neofetch

source $HOME/.config/broot/launcher/bash/br

source /home/lukefilewalker/.config/broot/launcher/bash/br

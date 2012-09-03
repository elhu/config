#= ALIASES

# GIT
alias ga='git add'
alias gl='git log'
alias gs='git status'
alias gsw='git show'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gco='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpl='git pull --rebase'
alias gps='git push'
alias gcl='git clone'
alias gsu='git submodule update --init'

# Ruby
alias t='bin/rspec --format nested'
alias rt='touch tmp/restart.txt'
alias rtd='touch tmp/debug.txt; rt'

# Apt
alias pkg-search='apt-cache search'
alias pkg-info='apt-cache showpkg'
alias pkg-install='sudo apt-get install'

# System
alias g='ack'

alias sudoedit='sudo -e'

if [[ "$OSTYPE" == darwin* ]]; then
  alias udb='sudo /usr/libexec/locate.updatedb'
else
  alias udb='sudo updatedb'
fi

alias topc='top -o cpu'
alias topm='top -o vsize'

#= SCREEN

s() {
    if [[ -f ~/screens/"$@" ]]; then 
        screen -U -c ~/screens/"$@"
    else
        echo "Screen file not found!"
    fi
}

#= VIM

v() {
    if [[ -f ".vimrc" ]]; then
        vim -S .vimrc
    else
        vim
    fi
}

#= PREZTO

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':omz:module:editor' keymap 'vi'

# Auto convert .... to ../..
zstyle ':omz:module:editor' dot-expansion 'yes'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':omz:*:*' case-sensitive 'no'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':omz:*:*' color 'yes'

# Auto set the tab and window titles.
zstyle ':omz:module:terminal' auto-title 'no'

# Set the Zsh modules to load (man zshmodules).
# zstyle ':omz:load' zmodule 'attr' 'stat'

# Set the Zsh functions to load (man zshcontrib).
# zstyle ':omz:load' zfunction 'zargs' 'zmv'

# Set the Oh My Zsh modules to load (browse modules).
# The order matters.
zstyle ':omz:load' omodule \
  'environment' \
  'terminal' \
  'editor' \
  'history' \
  'directory' \
  'spectrum' \
  'utility' \
  'completion' \
  'prompt'

# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
zstyle ':omz:module:prompt' theme 'minimal'

# This will make you shout: OH MY ZSHELL!
source "$OMZ/init.zsh"

#= ZSH

setopt NOMATCH
unsetopt BEEP HIST_BEEP LIST_BEEP
bindkey '^R' history-incremental-search-backward

# Stuff required only for this machine
if [[ -f ~/.zmachine ]]; then
  source ~/.zmachine
fi

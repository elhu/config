# The following lines were added by compinstall
zstyle :compinstall filename '/home/adrian/.zshrc'

case "$TERM" in
    xterm-color) color_prompt=yes;;
    rxvt-256color) TERM=rxvt-unicode;;
esac

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward
# End of lines configured by zsh-newuser-install

alias s ack-grep

PATH=$HOME/local/node/bin:$PATH

[[ -s "/home/adrian/.rvm/scripts/rvm" ]] && source "/home/adrian/.rvm/scripts/rvm"

alias ga='git add'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gco='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpl='git pull --rebase'
alias gps='git push'
alias gcl='git clone'

alias ha='hg add'
alias hp='hg push'
alias hl='hg log'
alias hs='hg status'
alias hd='hg diff'
alias hm='hg commit -m'
alias hma='hg commit -am'
alias hb='hg branch'
alias hc='hg checkout'
alias hra='hg remote add'
alias hrr='hg remote rm'
alias hpu='hg pull'
alias hcl='hg clone'

alias g='ack'
alias pkg-search='apt-cache search'
alias pkg-info='apt-cache showpkg'
alias pkg-install='sudo apt-get install'

alias t='bin/rspec --format nested'

s() {
    screen -c ~/screens/"$@"
}


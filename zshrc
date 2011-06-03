# The following lines were added by compinstall
zstyle :compinstall filename '/home/adrian/.zshrc'

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


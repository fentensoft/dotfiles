export ZSH=~/.oh-my-zsh
DISABLE_AUTO_UPDATE="true"
plugins=(git extract vi-mode zsh-autosuggestions zsh-syntax-highlighting fzf)
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi
export EDITOR="nvim"
export TERM=xterm-256color
export ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

alias vim="nvim"
setopt no_nomatch

bindkey  "${terminfo[khome]}"   beginning-of-line
bindkey  "${terminfo[kend]}"   end-of-line

export PATH="$HOME/.yarn/bin:$HOME/.local/bin:$PATH"
export LESSCHARSET=utf-8


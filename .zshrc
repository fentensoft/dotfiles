export ZSH=/usr/share/oh-my-zsh
DISABLE_AUTO_UPDATE="true"
plugins=(git extract vi-mode)
ZSH_CACHE_DIR=$HOME/.oh-my-zsh-cache
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi
export EDITOR="vim"
export TERM=xterm-256color
source $ZSH/oh-my-zsh.sh
source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

alias yay="yay --aururl https://aur.tuna.tsinghua.edu.cn"
alias pacman="sudo powerpill"
alias syu="pacman -Syu && yay -Syu"
alias npm="npm --registry=https://registry.npm.taobao.org \
    --cache=$HOME/.npm/.cache/cnpm \
    --disturl=https://npm.taobao.org/dist \
    --userconfig=$HOME/.cnpmrc"

neofetch


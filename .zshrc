export ZSH=/home/fentensoft/.oh-my-zsh
plugins=(extract)
zstyle ':completion:*' rehash true
export DEFAULT_USER="fentensoft"
export TERM="screen-256color"
export EDITOR='vim'
export http_proxy=http://127.0.0.1:4411
export https_proxy=http://127.0.0.1:4411
export DOCKER_HOST="127.0.0.1:4243"
export GOPATH="/home/fentensoft/go"
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs time)
export POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda context dir vcs)

source $ZSH/oh-my-zsh.sh
source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /etc/profile.d/autojump.zsh

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

alias pacman="sudo powerpill"
alias activate="source /home/fentensoft/source/miniconda3/bin/activate"
alias changeserver="sudo /home/fentensoft/source/miniconda3/bin/python3 /home/fentensoft/source/configs/changeserver.py"
alias jn="jupyter notebook"
alias npm="npm --registry=https://registry.npm.taobao.org \
    --cache=$HOME/.npm/.cache/cnpm \
    --disturl=https://npm.taobao.org/dist \
    --userconfig=$HOME/.cnpmrc"
alias ls="exa"

neofetch

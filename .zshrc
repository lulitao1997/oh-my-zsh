# Path to your oh-my-zsh installation.
  export ZSH=/home/lulitao/.oh-my-zsh

ZSH_THEME="minimal" # "imajes"

plugins=(git colored-man-pages notify vi-mode globalias) # zsh-vimode-visual)
# User configuration
# Preferred editor for local and remote sessions
export EDITOR='nvim'


source $ZSH/oh-my-zsh.sh

# disable ctrl+s
stty -ixon

# pip's install location
export PATH="$HOME/.local/bin:$PATH"

# Proxy settings
alias sp="export {http,https}_proxy='http://127.0.0.1:8118' && export all_proxy='socks5://127.0.0.1:1080'"
alias up="unset {http,https,all}_proxy"

if [[ -z $SSH_CONNECTION ]]; then
    sp
fi

# Alias, for ease of use
alias open='xdg-open'
alias sudo='sudo ' # using aliases under sudo
alias turn_off_screen='xset dpms force off'
eval $(thefuck --alias)
alias -g v='nvim'
alias -g n='nano'
alias -g p='pacman'
alias -g P='proxychains'
alias -g jce='jupyter-console --existing'
alias -g mpv6='mpv --ytdl-raw-options=force-ipv6='
alias -g V='nvim-qt'
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'

# Android SDK
export ANDROID_HOME=$HOME/.local/share/.Android/SDK
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:/home/lulitao/.android-studio/gradle/gradle-3.2/bin

# node.js
# don't wanna install in /usr/lib
PATH="$PATH:$HOME/.node_modules/bin"

# fzf
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

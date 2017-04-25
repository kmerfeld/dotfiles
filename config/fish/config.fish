set BROWSER firefox

alias vim nvim

alias nano /usr/bin/vim
alias irc "mosh home -- tmux a -t IRC"

set -gx PATH $HOME/dotfiles/scripts $PATH

set VISUAL nvim
set EDITOR "$VISUAL"

set -gx key value
set -gx TTC_WEATHER Fargo
set -gx TTC_CELSIUS false
set -gx TTC_APIKEYS false
set -gx TTC_REPOS $HOME,ndsu-ibm-capstone

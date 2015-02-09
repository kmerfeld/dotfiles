#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export EDITOR=vim

#this makes it run with 256 colors
if [ -e /usr/share/terminfo/x/xterm-256color ] && [ "$COLORTERM" == "xfce4-terminal" ]; then
	    export TERM=xterm-256color
    fi

#alias toxic= '/home/kyle/toxic/run_toxic.sh'
alias ls='ls --color=auto'
alias w3m='w3m duckduckgo.com'
export PS1='\[\033[01;32m\]\u@\h \[\033[00;31m\]\W \$ \[\033[00m\]'

set -o vi

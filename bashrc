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



alias sanic="./sanic/Sanicball_v0.6_linux/sanicball_v0.6.x86"


alias connect2smerf='ssh -o reconnect -R 8008:localhost:22 kyle@208.123.36.77'
alias ls='ls --color=auto'
export PS1='\[\033[01;32m\]\u@\h \[\033[00;31m\]\W \$ \[\033[00m\]'

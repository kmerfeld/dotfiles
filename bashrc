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

alias ls='ls --color=auto'
alias w3m='w3m duckduckgo.com'
alias netbeans="~/netbeans-8.0.2/bin/netbeans  --jdkhome ~/netbeans-8.0.2/jdk1.8.0_45/"
export PS2='\[\033[01;32m\]\u@\h \[\033[00;31m\]\W \$ \[\033[00m\]'
export PS1='\[\033[01;32m\]\u@\h \[\033[00;31m\]\W \$ \[\033[00m\]'
export PATH=/home/kyle/anaconda/bin/:$PATH
export PYTHONPATH=$PYTHONPATH:/home/kyle/anaconda/bin/chemlab
export PYTHONPATH=$PYTHONPATH:/home/kyle/chemlab/chemlab
set -o vi

#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
xmodmap ~/.Xmodmap
syndaemon -t -k -i 2 &
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
#this line is from https://wiki.archlinux.org/index.php/Touchpad_Synaptics
#it disables the touchpad while typeing
#syndaemon -t -k -i 2 &
 


[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
#exec plasma
#exec howm
exec i3
exec mate-session
#exec spectrwm 
exec startlxde
# exec startxfce4
# ...or the Window Manager of your choice
sh ~/.fehbg &


#!/bin/sh
userresources=$HOME/.Xresources
#usermodmap=$HOME/.Xmodmap
xinitdir=/etc/X11
sysresources=$xinitdir/Xresources
sysmodmap=$xinitdir/Xmodmap
 
# merge in defaults and keymaps
 
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
 
if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi
 
if [ -f $userresources ]; then
    xrdb -merge $userresources
fi
 
if [ -f $usermodmap ]; then
    xmodmap $usermodmap
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# [[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

exec startxfce4 

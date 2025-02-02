#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# shortcuts
xbindkeys &

# keyboard layout
setxkbmap -layout us,ru -option grp:alt_shift_toggle &

# display
$HOME/.bin/display "auto" 

# compositor
picom -f &

# wallpapers
nitrogen --restore &

# night light
redshift &

# bluetooth
$HOME/.bin/bluetooth &

# clipboard manager
clipmenud &

# phone connector
kdeconnect-indicator &

# system authentication agent
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# autolock
xautolock -time 10 -locker slock -killtime 10 -killer "systemctl suspend" -detectsleep -corners 0+-0 -cornerdelay 3 -cornersize 3 &

# dwm status bar
/$HOME/.environment/dwm-bar/dwm_bar.sh &

# dwm
while true; do
	dwm >/dev/null 2>&1
done

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi


setxkbmap fi

#xsetroot -cursor_name left_ptr &
xinput set-button-map "Microsoft Microsoft® Comfort Mouse 4500" 1 2 3 5 4 6 7 8 9 10 11 12 13 14 15 16    
xinput set-button-map "SynPS/2 Synaptics TouchPad" 1 2 3 5 4 6 7 8 9 10 11 12 13 14 15 16    

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xdefaults
redshift -l 61.475514:23.774414 &

# The following variable defines the session which is started if the user doesn't explicitly select a session
# Source: http://svn.berlios.de/svnroot/repos/slim/trunk/xinitrc.sample

DEFAULT_SESSION=startxfce4

case $1 in
i3)
	exec i3
	;;
xfce)
	exec startxfce4
	;;
X)
	exec xterm
	;;

*)
	urxvtd &
	trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16 &
	execxautolock -time 10 -locker "i3clock -c 000000"
	exec feh --bg-scale /home/lumolk/Kuvat/Wallpapers/current &
        #docky &
	exec xmonad

	;;
*)
	exec $DEFAULT_SESSION
	;;
esac


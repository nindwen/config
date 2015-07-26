#!/bin/sh
#
# z3bra - 2014 (c) wtfpl
# focus a window when it is created
# depends on: wew focus.sh

wew -a | while IFS=: read ev wid; do
case $ev in
   # window creation
   16) wattr o $wid \
      && chwb -s 2 -c 0x564444 $wid \
      || { corner md $wid; focus.sh $wid; } ;;

   # focus next window when deleting focused window
   18) wattr $(pfw) || focus.sh next 2>/dev/null;;

   # entering window
   7) wattr o $wid || focus.sh $wid ;;
esac
done

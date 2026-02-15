#!/bin/bash
# Send Ctrl+Shift+key in terminals, Ctrl+key elsewhere
WINDOW_CLASS=$(xdotool getactivewindow getwindowclassname 2>/dev/null)

case "$WINDOW_CLASS" in
    kitty|Alacritty|URxvt|XTerm|xfce4-terminal|com.mitchellh.ghostty)
        case "$1" in
            c) xdotool key ctrl+shift+c ;;
            v) xdotool key ctrl+shift+v ;;
            *) xdotool key ctrl+$1 ;;
        esac
        ;;
    *)
        xdotool key ctrl+$1
        ;;
esac

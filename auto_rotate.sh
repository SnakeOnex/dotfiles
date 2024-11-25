#!/bin/sh
monitor="eDP"
stylus="ELAN2514:00 04F3:42C1 Stylus Pen(0)"
touchscreen="ELAN2514:00 04F3:42C1"
eraser="ELAN2514:00 04F3:42C1 Stylus Eraser(0)" # stylus with a button pressed

xinput --map-to-output 9 "$monitor"
xinput --map-to-output 10 "$monitor"
xinput --map-to-output 11 "$monitor"
xinput --map-to-output 12 "$monitor"

monitor-sensor \
	| grep --line-buffered "Accelerometer orientation changed" \
	| grep --line-buffered -o ": .*" \
	| while read -r line; do
		line="${line#??}"
		if [ "$line" = "normal" ]; then
			rotate=normal
			matrix="1 0 0 0 1 0 0 0 1"
		elif [ "$line" = "left-up" ]; then
			rotate=left
            matrix="0 -1 1 1 0 0 0 0 1"
		elif [ "$line" = "right-up" ]; then
			rotate=right
			matrix="0 1 0 -1 0 1 0 0 1"
		elif [ "$line" = "bottom-up" ]; then
			rotate=inverted
			matrix="-1 0 1 0 -1 1 0 0 1"
		else
			echo "Unknown rotation: $line"
			continue
		fi

		xrandr --output "$monitor" --rotate "$rotate"
		if ! [ -z "$stylus" ]; then
			xinput set-prop "$stylus" --type=float "Coordinate Transformation Matrix" $matrix
            xinput set-prop "$touchscreen" --type=float "Coordinate Transformation Matrix" $matrix
            xinput set-prop "$eraser" --type=float "Coordinate Transformation Matrix" $matrix
		fi
	done

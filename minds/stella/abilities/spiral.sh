# spiral.sh - Voice Visualization Spiral (Preset By Krash)

# Launch ProjectM And Load Spiral Preset
projectM-pulseaudio & sleep .8 && xdotool key n;

# Set As Desktop Background
xprop -name "projectM" -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_DESKTOP

# Resize Window
wmctrl -r "projectM" -e "0, 0, 0, 400, 400";

# Center Window
winname='projectM'

IFS='x' read sw sh < <(xdpyinfo | grep dimensions | grep -o '[0-9x]*' | head -n1)

read wx wy ww wh < <(wmctrl -lG | grep $winname | sed 's/^[^ ]* *[^ ]* //;s/[^0-9 ].*//;');

wmctrl -r $winname -e 0,$(($sw/2-$ww/2)),$(($sh/2-$wh/2)),$ww,$wh;


#!/bin/bash

wofi_run="/tmp/wofi-clip.run"

if [ -f $wofi_run ]; then
    killall wofi
    rm $wofi_run
    exit 0
fi

mode=$1
shift

workspaces=$(swaymsg -t get_workspaces)

output_width=$(jq -r '.[] | select(.focused==true).rect.width' <<< $workspaces)
output_height=$(jq -r '.[] | select(.focused==true).rect.height' <<< $workspaces)

width=480
height=400

touch $wofi_run
wofi -p "clipboard: $mode" -s $HOME/.config/wofi/clip.css -W $width -H $height -y $(( $output_height / 2 - $height / 2 )) -x 0 -D line_wrap=char --show dmenu $*
rm $wofi_run

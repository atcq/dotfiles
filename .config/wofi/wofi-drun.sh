#!/bin/bash

wofi_run="/tmp/wofi-drun.run"

if [ -f $wofi_run ]; then
    killall wofi
    rm $wofi_run
    exit 0
fi

workspaces=$(swaymsg -t get_workspaces)

output_width=$(jq -r '.[] | select(.focused==true).rect.width' <<< $workspaces)
output_height=$(jq -r '.[] | select(.focused==true).rect.height' <<< $workspaces)

width=450
height=$(( $output_height / 2 - 20 ))

touch $wofi_run
wofi -p "launch:" -s $HOME/.config/wofi/menu.css -W $width -H $height -y 0 -x $(( $output_width / 2 - $width / 2 )) --show drun
rm $wofi_run

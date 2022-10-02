#!/usr/bin/env bash

wofi_run="/tmp/wofi-switch.run"

if [ -f $wofi_run ]; then
    killall wofi
    rm $wofi_run
    exit 0
fi

set -euo pipefail

workspaces=$(swaymsg -t get_workspaces)

output_width=$(jq -r '.[] | select(.focused==true).rect.width' <<< $workspaces)
output_height=$(jq -r '.[] | select(.focused==true).rect.height' <<< $workspaces)

width=480
height=400

#!/usr/bin/env bash
# Based on https://gist.github.com/lbonn/89d064cde963cfbacabd77e0d3801398 
#
# In order to have meaningful window names for terminals, use

# inside .vimrc:
# set title

# inside .bashrc:
# export PROMPT_COMMAND='echo -en "\033]0; $("pwd")  \a"'

touch $wofi_run
row=$(swaymsg -t get_tree | jq  -r '
    ..
    | objects
    | select(.type == "workspace") as $ws
    | ..
    | objects
    | select(has("app_id"))
    | (if .focused == true then "*" else " " end) as $asterisk
    | "<span weight=\"bold\">[\($ws.name)]\($asterisk)</span> <span weight=\"bold\">\(.app_id)</span> - \(.name) <!-- \(.id) -->"' \
    | sed 's/\[__i3_scratch\]/\[署\]/g' \
    | sed 's/\[1mix\]/\[\]/g' \
    | sed 's/\[2chat\]/\[\]/g' \
    | sed 's/\[3work\]/\[歷\]/g' \
    | sed 's/\[4media\]/\[\]/g' \
    | sed 's/\[5music\]/\[\]/g' \
    | sed 's/\[6chrome\]/\[\]/g' \
    | sed 's/\[7_mix\]/\[\]/g' \
    | sed 's/\[8edit\]/\[\]/g' \
    | sed 's/\[9misc\]/\[恵\]/g' \
    | sed 's/&/&amp;/g' \
    | wofi -d -s $HOME/.config/wofi/switch.css\
           -p "Windows: switch to..."\
           -W $width -H $height\
	   -x $(( $output_width - $width ))\
	   -y $(( $output_height / 2 - $height / 2 ))\
	   -markup-rows -D line_wrap=char)
rm $wofi_run

if [ ! -z "$row" ]
then
    winid=$(echo "$row" | sed 's/.*<!-- \([0-9]*\) -->.*/\1/')
    swaymsg "[con_id=$winid] focus"
fi

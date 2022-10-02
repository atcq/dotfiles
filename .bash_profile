#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# start sway on tty1 login
[ "$(tty)" = "/dev/tty1" ] && exec sway

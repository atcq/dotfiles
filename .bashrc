#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# default arch bashrc
[[ $DISPLAY ]] && shopt -s checkwinsize

PS1='[\u@\h \W]\$ '

case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'

    ;;
  screen*)
    PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
    ;;
esac

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh

# load more completions
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# my stuffz
# only unique history entries
export HISTCONTROL=ignoredups
# command not found
source /usr/share/doc/pkgfile/command-not-found.bash
# env vars
export EDITOR="nvim"
export TERM="kitty"

# various colors
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS='-R '
alias ping='prettyping'

# alias for your/my convenience
alias cat='bat'
alias pasteTB="nc termbin.com 9999"
alias dotfiles="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

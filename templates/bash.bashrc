# /etc/bash.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output. So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell. There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.

# If not running interactively, don't do anything!
[[ $- != *i* ]] && return

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize


#Automatically CD when just entering the path
shopt -s autocd

# Enable history appending instead of overwriting.
shopt -s histappend

HISTSIZE=5000
export HISTTIMEFORMAT="%F %T "

case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
		PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "work.dt" "${PWD/#$HOME/~}"'
		;;
	screen)
		PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033_%s@%s:%s\033\\" "${USER}" "work.dt" "${PWD/#$HOME/~}"'
		;;
esac


# fortune is a simple program that displays a pseudorandom message
# from a database of quotations at logon and/or logout.
# Type: "pacman -S fortune-mod" to install it, then uncomment the
# following line:

#[[ "$PS1" ]] && /usr/bin/fortune hitchhiker | ponysay
[[ "$PS1" ]] && /usr/bin/fortune | ponysay

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS. Try to use the external file
# first to take advantage of user additions. Use internal bash
# globbing instead of external grep binary.

# sanitize TERM:
safe_term=${TERM//[^[:alnum:]]/?}
match_lhs=""

[[ -f ~/.dir_colors ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs} ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)

if [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] ; then
	
	# we have colors :-)

	# Enable colors for ls, etc. Prefer ~/.dir_colors
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \w \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \")\$\[\033[00m\] "

	# Use this other PS1 string if you want \W for root and \w for all other users:
	# PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h\[\033[01;34m\] \W'; else echo '\[\033[01;32m\]\u@\h\[\033[01;34m\] \w'; fi) \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \")\$\[\033[00m\] "

else

	# show root@ when we do not have colors

	PS1="\u@\h \w \$([[ \$? != 0 ]] && echo \":( \")\$ "

	# Use this other PS1 string if you want \W for root and \w for all other users:
	# PS1="\u@\h $(if [[ ${EUID} == 0 ]]; then echo '\W'; else echo '\w'; fi) \$([[ \$? != 0 ]] && echo \":( \")\$ "

fi

PS2="> "
PS3="> "
PS4="+ "

# Try to keep environment pollution down, EPA loves us.
unset safe_term match_lhs

# Try to enable the auto-completion (type: "pacman -S bash-completion" to install it).
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Try to enable the "Command not found" hook ("pacman -S pkgfile" to install it).
# See also: [[Bash#The_.22command_not_found.22_hook]]
[ -r /usr/share/doc/pkgfile/command-not-found.bash ] && . /usr/share/doc/pkgfile/command-not-found.bash

EDITOR='vim'
VISUAL='vim'
LANG='en_US.UTF-8'

export EDITOR VISUAL LANG


# Coloured man pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
            man "$@"
}
#!/usr/bin/bash

## Aliases ##  {{{
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -C -h'
alias mkdir='mkdir -p -v'
alias dmesg='dmesg -HL'
alias da='date "%A, %B, %d, %Y [%T]"'
alias hist='history'
alias histg='history | grep'
alias ..='cd ..'
alias vi='vim'
alias sudo='sudo '

alias ls='ls -hF --color=auto'
alias ll='ls -lhF --color=auto'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'
alias ln='ln -i'
alias cd..='cd ..'
# }}}

## Privileged aliases ##  {{{
if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias root='sudo -s'
    alias reboot='sudo systemctl reboot'
    alias shutdown='sudo systemctl poweroff'
    if [ -e /usr/bin/yaourt ]; then
        alias update='yaourt -Syyu --aur'
    else
        alias update='sudo pacman -Syyu'
    fi
fi
# }}}

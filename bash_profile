if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

## brew install bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

# pyenv
if which pyenv > /dev/null; then
	eval "$(pyenv init -)";
fi

## env
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE=pwd:ls:cd:la:ll:lla:history:clear:vim:vi:cd??:cd???
export HISTTIMEFORMAT='%Y-%m-%d_%T '
export HISTFILESIZE=10000
export HISTSIZE=10000
export PS1="\[\e[32;1m\]\u@\[\e[34;1m\]\h:\W\\$ \[\e[0m\]"
export FTP_PASSIVE=1
export LSCOLORS=gxfxcxdxbxegedabagacad
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

shopt -s cdspell


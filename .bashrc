# .bashrc

# global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

export PATH=/usr/local/bin:$PATH:$HOME/bin

### set aliases
alias ls='ls -FG'
alias la='ls -A'
alias ll='ls -l'
alias lla='ls -Al'
alias mkdir='mkdir -p'
alias tree='tree -F -L 2'
alias rm='rmtrash'
alias lns='ln -s'


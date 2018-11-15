# .bashrc
# [c4augustus] customized based on Gentoo .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi
if [ -f /etc/bash/bashrc ]; then
    . /etc/bash/bashrc
fi
# (WSL Ubunutu 18.04)
if [ -f /etc/bash.bashrc ]; then
    . /etc/bash.bashrc
fi

export PATH=$PATH:$HOME/v/adjuncta/bin/bash
export PATH=$PATH:$HOME/v/adjuncta/bin/python
export PATH=$PATH:$HOME/v/adjuncta/bin/ruby

. init-bashrc
. init-prompt

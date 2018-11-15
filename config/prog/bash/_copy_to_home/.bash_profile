# .bash_profile
# [c4augustus] customized based on Gentoo .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

ENV=$HOME/.bashrc
USERNAME=$USER

export USERNAME ENV PATH

mesg n

. init-bash-profile

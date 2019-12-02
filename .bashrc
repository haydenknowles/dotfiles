# Hayden's bashrc

BASE16_SHELL=/home/hayden/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

if [ -f ~/.bash_aliases ] ; then
	source ~/.bash_aliases
fi

########## functions ############
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjvf $1     ;;
            *.tar.gz)    tar xvzf $1    ;;
			*.tar.xz)	 tar xf $1		;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xvf $1     ;;
            *.tbz2)      tar xvjf $1    ;;
            *.tgz)       tar xvzf $1    ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

monitorio () {
# show write speed for file or directory
    interval="10"
    target="$1"
    size=$(du -ks "$target" | awk '{print $1}')
    firstrun="1"
    echo ""
    while [ 1 ]; do
        prevsize=$size
        size=$(du -ks "$target" | awk '{print $1}')
        #size=$(ls -l "$1"  | awk '{print $5/1024}')
        kb=$((${size} - ${prevsize}))
        kbmin=$((${kb}* (60/${interval}) ))
        kbhour=$((${kbmin}*60))
        # exit if this is not first loop & file size has not changed
        if [ $firstrun -ne 1 ] && [ $kb -eq 0 ]; then break; fi
        echo -e "\e[1A $target changed ${kb}KB ${kbmin}KB/min ${kbhour}KB/hour size: ${size}KB"
        firstrun=0
        sleep $interval
    done
}

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#fd () { find . -name "*$1*";  }

_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}

####################################################

############# exports ###########
export PS1="\[\e[32m\]\u@\h \[\e[34m\]\W \[\e[33m\]$ \[\e[m\]"
export EDITOR=vim
export TERM=xterm-256color
export PS1="[\u:\W]\[\033[00m\] $ "
export PATH=/home/hayden/bin:/home/hayden/.local/bin:/home/hayden/.cargo/bin:$PATH
export LANG=en_NZ.UTF-8
#################################

# fix copy paste problems
#printf "\e[?2004l"

export FZF_DEFAULT_COMMAND='rg --files --hidden'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias fzf="fzf --preview 'head -100 {}'"

[ -f ~/.exercism_completion.bash ] && source ~/.exercism_completion.bash

complete -o default -F _pip_completion pip

# bind keys
if [ -t 1 ]; then
	bind '"\eOd": backward-word'
	bind '"\eOc": forward-word'
fi

. /etc/profile.d/vte.sh

#echo 'set completion-ignore-case On' >> ~/.inputrc # only do this once

#GTK_THEME=arc:darker

# build variables
#CPPFLAGS="I/opt/local/extra/include"
#export CPPFLAGS="I/opt/local/extra/include"
#export LDFLAGS="-L/opt/local/extra/lib"

# ./configure --prefix=/opt/local/extra CFLAGS="-I/opt/local/extra/include" LDFLAGS="-L/opt/local/extra/lib"

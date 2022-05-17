if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias j='z'
# PATH
set -g theme_display_git_master_branch yes
set -g fishrc $HOME/.config/fish/config.fish
set -g vimrc $HOME/.config/nvim/init.vim


# git
alias gs='git status'
alias ga='git add'
alias gps='git push'
alias gpl='git pull'
alias gcm='git commit'

#  vim
alias vim='nvim'

# xmodmap
alias xmod='xmodmap ~/.xmodmap'

# party parrot
alias parrot='curl parrot.live'

# fzf
function fzf-git-branch
    git rev-parse HEAD > /dev/null 2>&1 || return

    git branch --color=always --all --sort=-committerdate |
        grep -v HEAD |
        fzf --height 50% --ansi --no-multi --preview-window right:65% \
            --preview 'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed "s/.* //" <<< {})' |
        sed "s/.* //"
end

function fzf-git-checkout 
    git rev-parse HEAD > /dev/null 2>&1 || return

    local branch

    set branch $(fzf-git-branch)
    if test "$branch" = "" 
        echo "No branch selected."
        return
    end

    # If branch name starts with 'remotes/' then it is a remote branch. By
    # using --track and a remote branch name, it is the same as:
    # git checkout -b branchName --track origin/branchName
    if test "$branch" = 'remotes/'*
        git checkout --track $branch
    else
        git checkout $branch;
    end
end
alias gb='git branch'
alias gco='fzf-git-checkout'


# runcpp
function runcpp 
    echo -e "[\e[34mx\e[0m] g++ -std=gnu++17 -Wall -Wextra -O2 $argv[1] -o xxx.out"
    g++ -std=gnu++17 -Wall -Wextra -O2 $argv[1] -o xxx.out

    if test $status -ne 0
        echo -e "[\e[31m-\e[0m] compile failed"
    else
        echo -e "[\e[32m+\e[0m] successful complie"
        echo -e "[\e[34mx\e[0m] run ./xxx.out"
        ./xxx.out <input.txt> output.txt
    end
end

function runcpp-vim
    echo -e "g++ -std=gnu++17 -Wall -Wextra -O2 $argv[1] -o xxx.out"
    g++ -std=gnu++17 -Wall -Wextra -O2 $1 -o xxx.out

    if test $status -ne 0
        echo -e "compile failed"
    else
        echo -e "successful complie"
        echo -e "run ./xxx.out"
        ./xxx.out <input.txt> output.txt
    end
end

# vimrc
alias evim='vim $vimrc'
# fishrc
alias efish='vim $fishrc'
alias sfish='source $fishrc'

# rust


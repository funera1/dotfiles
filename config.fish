if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

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
alias gcm='git commit -m'

#  vim
alias vim='nvim'

# fish
alias efish='vim ~/.config/fish/config.fish'
alias sfish='source ~/.config/fish/config.fish'

# party parrot
alias parrot='curl parrot.live'

# k8s
alias k='kubectl'
alias kx='kubectx'

# pipecd
alias p='pipectl'

# python
alias py='python3'

# vim
alias evim='vim ~/.config/nvim/init.vim'


alias gfu="git push --force"
alias gff="git pull --ff-only"
alias gpf='git push --force-with-lease origin $(git_current_branch)'
alias gcfix="git commit --fixup"
alias k=kubectl

# oh-my-zsh git alias conflict with gds-cli
unalias gds

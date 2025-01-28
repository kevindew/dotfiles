alias gfu="git push --force"
alias gff="git pull --ff-only"
alias gpf='git push --force-with-lease origin $(git_current_branch)'
alias gcfix="git commit --fixup"
alias k=kubectl

# oh-my-zsh git alias conflict with gds-cli
unalias gds

function totp {
  output=$(ykman oath accounts code "$1")

  # assume that if we have one line it's got us a code
  line_count=$(echo "$output" | wc -l)

  if [ "$line_count" -eq 1 ]; then
    code=$(echo "$output" | awk '{print $NF}')
    echo "$output"           # Echo the full output to the screen
    echo -n "$code" | pbcopy # Copy only the code to the clipboard
    echo "Code copied to clipboard"
  else
    echo "$output"
  fi
}

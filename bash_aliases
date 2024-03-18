if [ -d "$HOME/govuk/govuk-puppet/development-vm" ]; then
  VAGRANT_GOVUK_ID=2cf48ee
  alias vm-vimrc="vm_copy ~/.vimrc"
  alias vm-dotfiles="vm_copy ~/.vimrc .vimrc;vm_copy ~/dotfiles/govuk-vm/zshrc .zshrc;vm_copy ~/dotfiles/bash_aliases .bash_aliases;vm_copy ~/dotfiles/govuk-vm/gitconfig .gitconfig;vm_copy ~/.gitignore_global .gitignore_global;vm_copy ~/.pryrc .pryrc;vm_copy ~/dotfiles/govuk-vm/setup.sh;vm_copy ~/dotfiles/git_template .git_template;vm_copy ~/dotfiles/govuk-vm/remote-postgres.sh remote-postgres.sh;vm_copy ~/dotfiles/psqlrc .psqlrc"
  alias vm-ssh-config="vagrant scp ~/.ssh/config ${VAGRANT_GOVUK_ID}:~/.ssh/config"
  alias vssh="ssh govuk-vm"
  alias vm-psql="psql -h localhost -p 15432 -U vagrant"
  alias vm-psql-publishing-api="vm-psql publishing_api_development"
fi
alias vpn-ah="sudo openconnect -v --pfs --no-dtls -u kevindew vpn.digital.cabinet-office.gov.uk/ah"
alias vpn-dr="sudo openconnect -v --pfs --no-dtls -u kevindew vpndr.digital.cabinet-office.gov.uk/ah"
alias sidekiq-staging-port-fw="ssh backend-1.backend.staging -CNL 9000:127.0.0.1:3211"
alias sidekiq-production-port-fw="ssh backend-2.backend.production -CNL 9000:127.0.0.1:3211"
alias sidekiq-integration-port-fw="ssh \$(ssh integration \"govuk_node_list --single-node -c backend\").integration -CNL 9000:127.0.0.1:3211"
alias publishing-api-integration-port-fw="ssh \$(ssh integration \"govuk_node_list --single-node -c publishing_api\").integration -CNL 9000:127.0.0.1:3093"
alias gfu="git push --force"
alias gff="git pull --ff-only"
alias gpf='git push --force-with-lease origin $(git_current_branch)'
alias gcfix="git commit --fixup"
alias k=kubectl

# oh-my-zsh git alias conflict with gds-cli
unalias gds
alias make-cinema-display-camera-work="sudo killall VDCAssistant"
function vm_copy {
  vagrant scp $1 ${VAGRANT_GOVUK_ID}:~/$2
}
alias ssh-integration="ssh \$(ssh integration \"govuk_node_list --single-node -c ${1}\").integration"

function ssh_integration {
  ssh $(ssh integration "govuk_node_list --single-node -c $1").integration
}

function ssh_aws_staging {
  ssh $(ssh aws-staging "govuk_node_list --single-node -c $1").aws-staging
}

function ssh_aws_production {
  ssh $(ssh aws-production "govuk_node_list --single-node -c $1").aws-production
}

# first argument: environment
# second argument: machine class
# third argument: extra input for ssh command
# example `govuk_ssh integration backend`
function govuk_ssh {
  # replace hyphens with underscores
  machine_class=${2//-/_}

  host=$(ssh $1 "govuk_node_list --single-node -c $machine_class")

  if [ -z "$host" ]; then
    red='\033[0;31m'
    nc='\033[0m'
    echo "${red}Failed to find a node for machine class $machine_class on $1${nc}"
    return 1
  fi

  echo "SSHing into $host.$1"
  ssh $host.$1 $(echo $3)
}

# first argument: environment
# second argument: machine class
# third argument: remote port
# fourth argument local port
# example `govuk_ssh_port_forward integration backend 9000 3211`
function govuk_ssh_port_forward {
  echo "Binding remote port $3 to local port $4, press ctrl+c to exit"
  govuk_ssh $1 $2 "-CNL $4:127.0.0.1:$3"
}

# first argument: environment
# second argument: machine class
# third argument: app name (defaults to machine class)
# example `govuk_ssh_app_console integration backend content-publisher`
function govuk_ssh_app_console {
  govuk_ssh $1 $2 "-t govuk_app_console ${3:-$2}"
}

# first argument: environment
# second argument: machine class
# third argument: app name (defaults to machine class)
# example `govuk_ssh_app_dbconsole integration backend content-publisher`
function govuk_ssh_app_dbconsole {
  govuk_ssh $1 $2 "-t govuk_app_dbconsole ${3:-$2}"
}

# first argument: environment
# second argument: local port: (optional)
# example `govuk_ssh_sidekiq_monitor integration`
function govuk_ssh_sidekiq_monitor {
  if [ -n "$2" ]; then
    local_port=$2
  else
    # find unusued port, from: https://superuser.com/a/1241589
    local_port=$(ruby -e 'require "socket"; puts Addrinfo.tcp("", 0).bind {|s| s.local_address.ip_port }')
  fi

  echo "Sidekiq monitor available at http://127.0.0.1:$local_port"

  govuk_ssh_port_forward $1 backend 3211 $local_port
}

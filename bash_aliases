VAGRANT_GOVUK_ID=2cf48ee
alias vm-vimrc="vm_copy ~/.vimrc"
alias vm-dotfiles="vm_copy ~/.vimrc;vm_copy ~/govuk-vm/.zshrc;vm_copy ~/govuk-vm/.bash_aliases;vm_copy ~/govuk-vm/.gitconfig;vm_copy ~/govuk-vm/setup.sh"
alias vm-ssh-config="vagrant scp ~/.ssh/config ${VAGRANT_GOVUK_ID}:~/.ssh/config"
alias vssh="vagrant ssh ${VAGRANT_GOVUK_ID}"
alias vpn-github="sudo openconnect vpn.digital.cabinet-office.gov.uk/github"
alias vpn-ah="sudo openconnect vpn.digital.cabinet-office.gov.uk/ah"
alias sidekiq-integration-port-fw="ssh backend-1.backend.integration -CNL 9000:127.0.0.1:80"
alias rabbitmq-integration-port-fw="ssh rabbitmq-1.backend.integration -L 15673:127.0.0.1:15672"

function vm_copy {
  vagrant scp $1 ${VAGRANT_GOVUK_ID}:~/
}

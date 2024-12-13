SCRIPTDIR=$(
  cd $(dirname $0)
  pwd
)

ln -s "${SCRIPTDIR}/zshrc" ~/.zshrc
ln -s ~/.zshrc ~/.zprofile
ln -s "${SCRIPTDIR}/bash_aliases" ~/.bash_aliases
ln -s "${SCRIPTDIR}/vimrc" ~/.vimrc
ln -s "${SCRIPTDIR}/pryrc" ~/.pryrc
ln -s "${SCRIPTDIR}/gitignore_global" ~/.gitignore_global
ln -s "${SCRIPTDIR}/ssh-config" ~/.ssh/config
ln -s "${SCRIPTDIR}/gitconfig" ~/.gitconfig
ln -s "${SCRIPTDIR}/Brewfile" ~/Brewfile

ln -s "${SCRIPTDIR}/psqlrc" ~/.psqlrc

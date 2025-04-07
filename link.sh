SCRIPTDIR=$(
  cd $(dirname $0)
  pwd
)

ln -s "${SCRIPTDIR}/zshrc" ~/.zshrc
ln -s ~/.zshrc ~/.zprofile
ln -s "${SCRIPTDIR}/bash_aliases" ~/.bash_aliases
ln -s "${SCRIPTDIR}/vimrc" ~/.vimrc
ln -s "${SCRIPTDIR}/pryrc" ~/.pryrc
ln -s "${SCRIPTDIR}/ssh-config" ~/.ssh/config
ln -s "${SCRIPTDIR}/gitconfig" ~/.gitconfig
ln -s "${SCRIPTDIR}/Brewfile" ~/Brewfile

if [ ! -d ~/.config ]; then
  mkdir "~/.config"
fi
ln -s "${SCRIPTDIR}/nvim" ~/.config/nvim
if [ ! -d ~/.config/git ]; then
  mkdir "~/.config/git"
fi
ln -s "${SCRIPTDIR}/gitignore_global" ~/.config/git/ignore
ln -s "${SCRIPTDIR}/psqlrc" ~/.psqlrc

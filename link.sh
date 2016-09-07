SCRIPTDIR=$(cd `dirname $0`; pwd)

ln -s "${SCRIPTDIR}/zshrc" ~/.zshrc
ln -s ~/.zshrc ~/.zprofile
ln -s "${SCRIPTDIR}/bash_aliases" ~/.bash_aliases
ln -s "${SCRIPTDIR}/vimrc" ~/.vimrc
ln -s "${SCRIPTDIR}/pryrc" ~/.pryrc
ln -s "${SCRIPTDIR}/gitignore_global" ~/.gitignore_global
ln -s "${SCRIPTDIR}/ssh-config" ~/.ssh/config
if [ -d ~/.git_template ]; then
  echo "~/.git_template already exists"
else
  ln -s "${SCRIPTDIR}/git_template" ~/.git_template
fi
ln -s "${SCRIPTDIR}/psqlrc" ~/.psqlrc

git config --global init.templatedir '~/.git_template'
git config --global alias.ctags '!.git/hooks/ctags'

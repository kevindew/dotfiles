if [ ! -d govuk ]; then
 ln -s /var/govuk govuk
fi

if [ ! -f /bin/zsh ]; then
  sudo apt update
  sudo apt-get install zsh --assume-yes
fi

if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [ ! -d ~/.config/base16-shell ]; then
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

if [ ! -f /usr/bin/gpg-agent ]; then
  sudo apt update
  sudo apt-get install gnupg-agent --assume-yes
fi

sudo sh -c 'echo "host  all     all 10.0.2.2/32 trust" >> /etc/postgresql/9.3/main/pg_hba.conf'
sudo service postgresql restart

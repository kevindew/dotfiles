sudo apt-get install zsh --assume-yes
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
chsh -s /bin/zsh
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
sudo apt update
sudo apt install python3-dev python3-pip --assume-yes
sudo -H pip3 install thefuck
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

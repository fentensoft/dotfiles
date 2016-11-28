# Install ZSH
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -sf $(pwd)/.zshrc ~/.zshrc

#Install Vim
sudo apt install vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
ln -sf $(pwd)/.vimrc ~/.vimrc

# Install ZSH
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -sf $(pwd)/.zshrc ~/.zshrc

#Install Vim
sudo apt install vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PluginInstall +qall
ln -sf $(pwd)/.vimrc ~/.vimrc

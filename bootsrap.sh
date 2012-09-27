#!/bin/sh

echo ""
echo "----------------------"
echo "Installing Homebrew"
echo "----------------------"
echo ""

curl -fsSkL raw.github.com/mxcl/homebrew/go | ruby
brew doctor

echo ""
echo "Installing ack, ctags, git, git-extras, hub, node, rbenv, ruby-build & zsh"

brew update
brew install ack ctags git git-extras hub rbenv ruby-build node zsh


echo ""
echo "----------------------"
echo "Installing Prezto"
echo "----------------------"
echo ""

echo ""
echo "Cloning repo..."

git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto

echo ""
echo "Copy/link Zsh config files..."

ln -s ~/.zprezto/runcoms/zshenv ~/.zshenv
ln -s $PWD/zshrc ~/.zshrc
ln -s $PWD/zpreztorc ~/.zpreztorc
ln -s ~/.zprezto/runcoms/zlogin ~/.zlogin
ln -s ~/.zprezto/runcoms/zlogout ~/.zlogout
ln -s $PWD/powconfig ~/.powconfig

echo ""
echo "Set Zsh as your default shell..."

sudo echo "/usr/local/bin/zsh" >> /etc/shells
chsh -s /usr/local/bin/zsh

echo ""
echo "Fixing pathing problems..."

sudo chmod ugo-x /usr/libexec/path_helper
sudo mv /etc/zshenv /etc/zprofile

echo ""
echo "----------------"
echo "Configuring Vim"
echo "----------------"
echo ""

ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/vim ~/.vim

echo ""
echo "----------------"
echo "Configuring Git"
echo "----------------"
echo ""

ln -s $PWD/gitconfig ~/.gitconfig
ln -s $PWD/gitignore ~/.gitignore

echo ""
echo "----------------"
echo "Wrap-up"
echo "----------------"
echo ""

echo ""
echo "Touching .secrets, don't forget to populate it"

touch ~/.secrets

echo ""
echo "...last but not least, install the fonts in ~/.dotfiles/fonts/"

echo ""
echo "DONE!"

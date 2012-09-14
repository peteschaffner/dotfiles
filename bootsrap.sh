#!/bin/sh

echo ""
echo "----------------------"
echo "Installing Homebrew"
echo "----------------------"
echo ""

curl -fsSkL raw.github.com/mxcl/homebrew/go | ruby
brew doctor

echo ""
echo "Installing ack, ctags, git, git-extras, hub, node, rbenv & ruby-build..."

brew update
brew install ack ctags git git-extras hub rbenv ruby-build node


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

cp ~/.zprezto/runcoms/zlogin ~/.zshenv
ln -s $PWD/zprofile ~/.zprofile
ln -s $PWD/zshrc ~/.zshrc
ln -s $PWD/zpreztorc ~/.zpreztorc
cp ~/.zprezto/runcoms/zlogin ~/.zlogin
cp ~/.zprezto/runcoms/zlogout ~/.zlogout

echo ""
echo "Set Zsh as your default shell..."

chsh -s /bin/zsh

echo ""
echo "Fixing pathing problem introduced in Leopard..."

sudo chmod ugo-x /usr/libexec/path_helper

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

#!/bin/zsh

#########################
# Setup Homebrew and Cask
#########################

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew install ag caskroom/cask/brew-cask cmake fasd git git-extras hub vim
# Install Node and NPM
brew install node --without-npm
curl -L https://www.npmjs.com/install.sh | sh
brew cask install karabiner seil


##############
# Setup Prezto
##############

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
zsh
setopt EXTENDED_GLOB

for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

chsh -s /bin/zsh


###################################
# Create symbolic links to dotfiles
###################################

dotfiles=(~/.dotfiles/{agignore,git*,jshintrc,netrc,tern-config,vim,z*})

for dotfile in $dotfiles; do
  ln -fs "$dotfile" ~/".${dotfile:t}"
done


###########
# Setup Vim
###########

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


#########################
# Link system keybindings
#########################

keyindingsDir=~/Library/KeyBindings

mkdir -p $keyindingsDir
ln -fs ~/.dotfiles/DefaultKeyBinding.dict $keyindingsDir


################################
# Set app shortcuts
################################

# Key:
# control => ^
# option => ~
# command => @
# shift => $
# Nested->Menu Item => \033Nested\033Menu Item

# Sketch
defaults write com.bohemiancoding.sketch3 NSUserKeyEquivalents '{
    "Hide Colors" = "@$c";
    "Show Colors" = "@$c";
    "Flatten Selection to Bitmap" = "@$f";
    "Scale..." = "@^s";
    "Round to Pixel" = "@~r";
    "\033Arrange\033Align\033Top" = "@^k";
    "\033Arrange\033Align\033Right" = "@^l";
    "\033Arrange\033Align\033Bottom" = "@^j";
    "\033Arrange\033Align\033Left" = "@^h";
    "\033Arrange\033Align\033Vertically" = "@^-";
    "\033Arrange\033Align\033Horizontally" = "@^\\";
    "\033Arrange\033Distribute\033Vertically" = "$@^-";
    "\033Arrange\033Distribute\033Horizontally" = "$@^\\";
}'

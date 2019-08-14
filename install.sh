#!/bin/bash

# These are the packages that I want to have when I setup a new machine.
# Many of them are stupid but you need stupid in the terminal!

sudo -v

# Update the cache and install updates before starting
sudo apt update && sudo apt upgrade -y

# Check if git is installed, if not install it.
if ! [ -x "$(command -v git)" ]; then
	sudo apt install git
else
	echo "git already installed."
fi

# Check if tmux is installed, if not install it.
if ! [ -x "$(command -v tmux)" ]; then
	sudo apt install tmux
else
	echo "tmux already installed."
fi

# Check if weechat is installed, if not install it.
if ! [ -x "$(command -v weechat)" ]; then
	sudo apt install weechat
else
	echo "weechat already installed."
fi

# Check if vim is installed, if not install it.
if ! [ -x "$(command -v vim)" ]; then
	sudo apt install vim
else
	echo "vim already installed."
fi

# Check if ssh is installed, if not install it.
if ! [ -x "$(command -v ssh)" ]; then
	sudo apt install openssh-server
else
	echo "openssh-server already installed."
fi

# Create some directories
mkdir $HOME/.ssh
mkdir $HOME/.tmux
mkdir $HOME/.vim
mkdir $HOME/.weechat

# Clone some repos
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Link some of the files
ln -s $HOME/dotfiles/.tmux.conf $HOME/$filename
ln -s $HOME/dotfiles/.vimrc $HOME/$filename
ln -s $HOME/dotfiles/.vim-template.html $HOME/.vim/$filename
ln -s $HOME/dotfiles/.vim-template.bash $HOME/.vim/$filename

# vim command
vim +PluginInstall +qall

# Cleaning
sudo apt autoremove
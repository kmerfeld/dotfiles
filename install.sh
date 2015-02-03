#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="pentadactylrc i3 bashrc zshrc vimrc vim tmux.conf xinitrc rofi.sh Xresources"     # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done


#install vim plugins from git
git clone https://github.com/nanotech/jellybeans.vim.git ~/dotfiles/vim/bundle/jellybeans.vim
git clone https://github.com/scrooloose/nerdtree.git ~/dotfiles/vim/bundle/nerdtree
git clone https://github.com/ervandew/supertab.git ~/dotfiles/vim/bundle/supertab
git clone https://github.com/terryma/vim-expand-region.git ~/dotfiles/vim/bundle/vim-expand-region


#changes the shell to zsh. need to clean this up
chsh -s $(which zsh)

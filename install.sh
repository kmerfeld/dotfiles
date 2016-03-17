#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################



###################
# Setup Variables #
###################
addedstuff=$1
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory

#these files will be copied to the home directory
files="i3blocks taskrc i3 bashrc vimrc vim tmux.conf xinitrc Xresources"     # list of files/folders to symlink in homedir

#these files are copied to ~/.config
configFiles="fish"

#These will be installed if you are running arch (with AUR support)
toInstall="tmux dmenu vim neovim i3 task fish lxtask"




##########################
# linking config scripts #
##########################

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
mkdir -p $olddir/config
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
	mv ~/.$file ~/dotfiles_old/
	echo "Creating symlink to $file in home directory."
	ln -s $dir/$file ~/.$file
done
for file in $configFiles; do
	mv ~/.config/$file ~/dotfiles_old/config/
	echo "Creating symlink to $file in ~/.config directory."
	ln -s $dir/$file ~/.config/$file
done

if [ -f ~/.config/nvim ]
then
	ln -s ~/.vim ~/.config//nvim
fi

#################
# task certs	# 
#################

#unencrypting and extracting task sync items
if [[ -f certs/*.pem ]]
then
	gpg -o certs/inthe.am.tar.gz -d certs/inthe.am.tar.gz.gpg 
	cd ~/dotfiles/certs
	tar -xvf inthe.am.tar.gz
	cd ..
fi



#######################
# arch specific stuff #
#######################

if [[ -f /etc/pacman.conf ]] 
then
	#install pacaur
	w="$(which pacaur)"
	if [[ $w != /usr/bin/pacaur  ]]  

	then 
		#install cower (a dependancy of pacaur)
		echo "installing cower" sudo pacman -S wget --needed base-devel 
		cd /tmp
		wget https://aur.archlinux.org/cgit/aur.git/snapshot/cower.tar.gz
		tar -xvf cower.tar.gz
		cd cower 
		makepkg -sri --skippgpcheck #i should probably fix this to not just skip

		#install pacaur
		echo "installing pacuar"
		cd /tmp
		wget https://aur.archlinux.org/cgit/aur.git/snapshot/pacaur.tar.gz
		tar -xvf pacaur.tar.gz
		cd pacaur
		makepkg -sri
	fi

	#installing files
	pacaur -S $toInstall

	#setting fish to default
	chsh -s /usr/bin/fish

fi

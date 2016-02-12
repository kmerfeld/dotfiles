#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables
addedstuff=$1
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="taskrc mutt i3 bashrc vimrc vim tmux.conf xinitrc Xresources"     # list of files/folders to symlink in homedir

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


###################
#unencrypting and extracting task sync items
gpg -o certs/inthe.am.tar.gz -d certs/inthe.am.tar.gz.gpg 
cd ~/dotfiles/certs
tar -xvf inthe.am.tar.gz
cd ..


###################
#check if distro is arch
if [[ -f /etc/pacman.conf ]] 
then
	#install pacaur
	w="$(which pacaur)"
	if [[ $w != /usr/bin/pacaur  ]]  

	then 
		#install cower (a dependancy of pacaur)
		echo "installing cower"
		sudo pacman -S wget --needed base-devel 
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

	#Run things only done if arch is installed
	pacman -S dmenu vim i3 mutt task
fi

#install st
git clone https://github.com/kmerfeld/st
cd st
make
make install
cd ..


#link neovim config files to vim ones
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim

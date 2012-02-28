#!/usr/bin/env bash

if [ -z "$PS1" ]; then
  echo -e "${COLOR_RED}You should source this file, not run it; e.g. source ./`basename $0`${COLOR_NC}"
else

  symlink (){
    if [ -e $1 ]; then
      # delete with confirmation (to avoid cursing)
      if [ -e $2 ]; then
        rm -i $2
      fi

      # create symlink only if target doesn't exist (e.g. if the user declined deletion)
      if [ ! -e $2 ]; then
        ln -s $1 $2
      fi
    fi
  }

  # create symlinks in a configuration-independent manner
  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  # binaries
  symlink $DIR/bin ~/.bin

  # bash
  symlink $DIR/etc/bash_profile ~/.bash_profile
  symlink $DIR/etc/bashrc ~/.bashrc
  symlink $DIR/etc/bashrc_help ~/.bashrc_help
  symlink $DIR/etc/bashrc_app_specific ~/.bashrc_app_specific

  # vim
  symlink $DIR/etc/vim/vimrc ~/.vimrc
  symlink $DIR/etc/vim/gvimrc ~/.gvimrc
  symlink $DIR/etc/vim ~/.vim

  # git
  symlink $DIR/etc/gitconfig ~/.gitconfig
  symlink $DIR/etc/gitignore ~/.gitignore
  symlink $DIR/etc/gitattributes ~/.gitattributes

  # misc
  symlink $DIR/etc/subversion ~/.subversion
  symlink $DIR/etc/autotest ~/.autotest
  symlink $DIR/etc/irbrc ~/.irbrc
  # symlink $DIR/etc/ssh_config ~/.ssh/config

  echo "Your home directory's symbolic links now point to the files in \"$DIR/etc\""
  echo "You should re-run this script if \"$DIR\" is ever moved"

  source ~/.bash_profile
fi

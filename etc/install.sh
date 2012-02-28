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
  symlink "$( cd $DIR/../bin && pwd )" ~/.bin

  # bash
  symlink $DIR/bash_profile ~/.bash_profile
  symlink $DIR/bashrc ~/.bashrc
  symlink $DIR/bashrc_help ~/.bashrc_help
  symlink $DIR/bashrc_app_specific ~/.bashrc_app_specific

  # vim
  symlink $DIR/vim/vimrc ~/.vimrc
  symlink $DIR/vim/gvimrc ~/.gvimrc
  symlink $DIR/vim ~/.vim

  # git
  symlink $DIR/gitconfig ~/.gitconfig
  symlink $DIR/gitignore ~/.gitignore
  symlink $DIR/gitattributes ~/.gitattributes

  # misc
  symlink $DIR/subversion ~/.subversion
  symlink $DIR/autotest ~/.autotest
  symlink $DIR/irbrc ~/.irbrc
  # symlink $DIR/ssh_config ~/.ssh/config

  echo "Your home directory's symbolic links now point to the files in \"$DIR\""
  echo "You should re-run this script if \"$DIR\" is moved"

  source ~/.bash_profile
fi

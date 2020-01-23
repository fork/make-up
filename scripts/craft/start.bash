#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

file_root=.env
file=site/.env

# create .env in project root
if [ ! -f "$file_root" ]; then
  echo
  echo "  ${BLUE}TASK${NC} Create reference to $file in project root"
  echo

  ln -s $file $file_root

  if [ -f "$file_root" ]; then
    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  else
    echo
    echo "  ${RED}ERROR${NC} Could not create $file_root"
    echo
  fi
fi

# Craft CMS (composer install)
if [ -d "site" ]; then
  # setup environment
  if [ ! -f "$file" ]; then
    $my_dir/env.bash
  fi

  # check if we need a 'composer install' if craft is already included
  if [ ! -d "site/vendor" ]; then
    $my_dir/../composer/install.bash
  fi

  if [ -d "site/config" ]; then
    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  else
    echo
    echo "  ${RED}ERROR${NC} Could not find Craft"
    echo
  fi

  # display project information
  $my_dir/info.bash
fi

#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

# Craft CMS 3 (install)
if [ ! -d "site/config" ]; then
  echo
  echo "  ${BLUE}TASK${NC} Craft CMS 3"
  echo

  echo -n "Would you like to install Craft CMS 3 (y/n)? "
  read answer

  if [ "$answer" != "${answer#[Yy]}" ]; then
    $my_dir/install.bash
  else
    echo
    echo "  ${YELLOW}WARNING${NC} Skipped"
    echo
  fi
fi

# Craft CMS (composer install)
if [ -d "site" ]; then
  $my_dir/env.bash

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
fi

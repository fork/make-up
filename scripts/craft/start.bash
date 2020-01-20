#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

# Craft CMS (composer install)
if [ -d "site" ]; then
  # setup environment
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

  # display project information
  $my_dir/info.bash
fi

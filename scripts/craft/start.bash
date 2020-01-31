#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

file=site/.env

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
    echo "$I18N_SUCCESS Done"
    echo
  else
    echo
    echo "$I18N_ERROR Could not find Craft"
    echo
  fi

  # display project information
  $my_dir/info.bash
fi

# more-make-up
MORE_MAKE_UP="${0/make-up/more-make-up}"
if [ -f "$MORE_MAKE_UP" ]; then
  echo
  echo "$I18N_TASK Run more Make-up from $MORE_MAKE_UP"
  echo

  $MORE_MAKE_UP

  echo
  echo "$I18N_SUCCESS Done"
  echo

  ok=true
fi
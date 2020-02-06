#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Craft 3' → Start"
echo

ok=false

# Craft CMS (composer install)
if [ "$IDENT_CRAFT_3" = true ]; then
  file=site/.env

  # setup environment
  if [ ! -f "$file" ]; then
    $my_dir/env.bash
  fi

  # check if we need a 'composer install' if craft is already included
  if [ ! -d "site/vendor" ]; then
    $my_dir/../composer/install.bash
  fi

  if [ "$IDENT_CRAFT_3" = true ]; then
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

  ok=true
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
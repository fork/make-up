#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK Enter shell"
echo

ok=false

# try craft 3
if [ "$IDENT_DOCKER" = true ]; then
  $my_dir/../craft-3/shell.bash
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

if [ "$ok" = true ]; then
  echo
  echo "$I18N_SUCCESS Done"
  echo
else
  echo
  echo "$I18N_ERROR Could not find a method to execute command"
  echo
fi

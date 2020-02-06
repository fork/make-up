#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Craft 3' → Enter shell in docker container"
echo

ok=false

if [ "$IDENT_DOCKER" = true ]; then
  docker-compose exec php /bin/sh

  echo
  echo "$I18N_SUCCESS Done"
  echo

  ok=true
else
  echo
  echo "$I18N_ERROR Docker is required to run this command"
  echo  
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
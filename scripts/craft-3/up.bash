#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Craft 3' → Setting up docker"
echo

ok=false

if [ "$IDENT_DOCKER" = true ]; then
	if [ "${DISABLE_PROXY:-false}" = false ]; then
	  docker ps | grep -q nginx-proxy || $my_dir/proxyup.bash
	fi
  docker-compose up -d $ADDITIONAL_UP_ARGS

  # install Craft 3 if not found
  if [ ! "$IDENT_CRAFT_3" = true ]; then
    $my_dir/install.bash
  fi

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
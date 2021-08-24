#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Craft 3' → Install"
echo

ok=false

if [ ! "$IDENT_CRAFT_3" = true ]; then
  echo -n "Would you like to install 'Craft 3' with docker? (y/n)"
  read answer

  if [ "$answer" != "${answer#[Yy]}" ]; then
    if [ "$IDENT_DOCKER" = true ]; then
      echo
      echo "$I18N_TASK 'Craft 3' → Installing..."
      echo
      docker-compose exec "${DOCKER_CRAFT_SERVICE:-craft}" composer create-project craftcms/craft /var/www/html
      docker-compose exec "${DOCKER_CRAFT_SERVICE:-craft}" composer --working-dir="${DOCKER_WORKING_DIR:-/var/www/html}" require --dev squizlabs/php_codesniffer
    else
      echo
      echo "$I18N_ERROR Docker is required to run this command"
      echo
    fi
  else
    echo
    echo "$I18N_WARNING Skipped"
    echo
  fi
else
  echo
  echo "$I18N_WARNING Craft 3 is already installed"
  echo
fi

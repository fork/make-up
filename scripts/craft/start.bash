#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

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

  echo
  echo "  ${BLUE}TASK${NC} Display project information"
  echo

  # craft
  echo "  → ${BOLD}Frontend${NC}"
  echo "    http://$FOLDER_NAME.localhost/"

  # craft backend
  echo
  echo "  → ${BOLD}Backend${NC}"
  echo "    http://$FOLDER_NAME.localhost/admin"

  # mailhog
  echo
  echo "  → ${BOLD}Mailhog${NC}"
  echo "    http://mailhog.$FOLDER_NAME.localhost"

  # env-file
  echo 
  echo "  → ${BOLD}Env-file${NC}"
  echo "    ${ENV_FILE}"

  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
fi

#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

# Craft CMS project information
if [ -d "site" ]; then
  echo
  echo "$I18N_TASK Craft CMS 3"
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
  echo "    site/.env"
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
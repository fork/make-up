#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

ok=false

echo
echo "$I18N_TASK 'Craft 3' → Info"
echo

# Display docker images
if [ "$IDENT_DOCKER" = true ]; then

  docker-compose images

  ok=true
fi

# Craft CMS project information
if [ "$IDENT_CRAFT_3" = true ]; then
  # craft
  echo 
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
#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Git' → Info"
echo

repository=$(git config --get remote.origin.url)
domain="${repository[@]//://}"
domain="${domain[@]//.git/}"
domain="${domain[@]//git@/}"
domain="https://${domain}"
pipelines="${domain}/-/pipelines"

if [ -n "$repository" ]; then
  echo "  → ${BOLD}Repository${NC}"
  echo "    $domain"
  echo
  echo "  → ${BOLD}Pipelines${NC}"
  echo "    $pipelines"
  echo
  echo "$I18N_SUCCESS Done"
  echo
else
  echo
  echo "$I18N_ERROR Could not find repository"
  echo
fi

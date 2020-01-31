#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK Git info"
echo

repository=$(git config --get remote.origin.url)

if [ -n "$repository" ]; then
  echo "  → ${BOLD}Repository${NC}"
  echo "    $repository"
  echo
  echo "$I18N_SUCCESS Done"
  echo
else
  echo
  echo "$I18N_ERROR Could not find repository"
  echo
fi

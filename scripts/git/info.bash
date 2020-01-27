#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Git info"
echo

repository=$(git config --get remote.origin.url)

if [ -n "$repository" ]; then
  echo "  → ${BOLD}Repository${NC}"
  echo "    $repository"
  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
else
  echo
  echo "  ${RED}ERROR${NC} Could not find repository"
  echo
fi

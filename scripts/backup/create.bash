#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Backup data"
echo

ok=false

# try docker
if [ -d "docker" ]; then
  $my_dir/../docker/backup.bash
  ok=true
fi

if [ "$ok" = true ]; then
  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
else
  echo
  echo "  ${RED}ERROR${NC} Could not find a method to execute command"
  echo
fi
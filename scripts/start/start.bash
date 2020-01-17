#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Start developing"
echo

# try docker
if [ -d "docker" ]; then
  # stop docker container
  $my_dir/../docker/up.bash

  # try craft
  $my_dir/../craft/start.bash

  ok=true
fi

# try node_modules
$my_dir/node_modules.bash

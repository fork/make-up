#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Stopping docker"
echo

docker-compose stop

echo
echo "  ${GREEN}SUCCESS${NC} Done"
echo
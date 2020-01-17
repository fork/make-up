#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Stop"
echo

# Docker
if [ -d "docker" ]; then 
  $my_dir/../docker/stop.bash
fi
#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Display project information"
echo

# try craft
$my_dir/../craft/info.bash

echo
echo "  ${GREEN}SUCCESS${NC} Done"
echo

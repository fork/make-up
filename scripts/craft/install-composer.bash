#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Install composer"
echo

docker-compose exec php composer --working-dir=/var/www/html install

echo
echo "  ${GREEN}SUCCESS${NC} Done"
echo
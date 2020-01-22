#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} 🐳 Enter shell"
echo

docker-compose exec php /bin/sh

echo
echo "  ${GREEN}SUCCESS${NC} Done"
echo
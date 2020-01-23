#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} 🐳 Enter database shell"
echo

docker-compose exec db $DB_DRIVER -u$DB_USER -p$DB_PASSWORD -h$DB_SERVER $DB_DATABASE

echo
echo "  ${GREEN}SUCCESS${NC} Done"
echo

#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Enter database shell"
echo

ok=false

# try docker
if [ -d "docker" ]; then
  docker-compose exec db $DB_DRIVER -u$DB_USER -p$DB_PASSWORD -h$DB_SERVER $DB_DATABASE
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

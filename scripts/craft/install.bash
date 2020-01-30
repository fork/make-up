#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Craft CMS 3"
echo

echo -n "Would you like to install Craft CMS 3 (y/n)? "
read answer

if [ "$answer" != "${answer#[Yy]}" ]; then
  docker-compose exec php composer create-project craftcms/craft /var/www/html
else
  echo
  echo "  ${YELLOW}WARNING${NC} Skipped"
  echo
fi
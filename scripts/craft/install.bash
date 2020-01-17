#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Install Craft CMS 3"
echo

rm -rf site
mkdir site
docker-compose exec php composer create-project craftcms/craft /var/www/html

# run env.bash
$my_dir/env.bash

if [ -d "site/config" ]; then
  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
else
  echo
  echo "  ${RED}ERROR${NC} Could verify Craft installation"
  echo
fi
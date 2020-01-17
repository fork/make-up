#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Install Craft CMS 3"
echo

mkdir -p site
docker-compose exec php composer create-project craftcms/craft /var/www/html

echo
echo "  ${GREEN}SUCCESS${NC} Done"
echo
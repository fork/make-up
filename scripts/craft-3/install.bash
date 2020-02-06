#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK Craft CMS 3"
echo

echo -n "Would you like to install Craft CMS 3 (y/n)? "
read answer

if [ "$answer" != "${answer#[Yy]}" ]; then
  docker-compose exec php composer create-project craftcms/craft /var/www/html
  docker-compose exec php composer --working-dir=/var/www/html require --dev squizlabs/php_codesniffer
else
  echo
  echo "$I18N_WARNING Skipped"
  echo
fi
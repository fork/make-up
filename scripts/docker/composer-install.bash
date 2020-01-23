#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} 🐳 Run composer install"
echo

docker-compose exec php composer --working-dir=/var/www/html install

if [ -d "site/vendor" ]; then
  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
  ok=true
else
  echo
  echo "  ${RED}ERROR${NC} Could not verify composer installation: site/vendor not found."
  echo
fi

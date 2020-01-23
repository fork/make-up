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

# more-make-up
MORE_MAKE_UP="${0/make-up/more-make-up}"
if [ -f "$MORE_MAKE_UP" ]; then
  echo
  echo "  ${BLUE}TASK${NC} Run more Make-up from $MORE_MAKE_UP"
  echo

  $MORE_MAKE_UP

  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo

  ok=true
fi
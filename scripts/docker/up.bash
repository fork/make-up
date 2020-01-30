#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} 🐳 Setting up docker"
echo

docker ps | grep -q nginx-proxy || $my_dir/proxyup.bash
docker-compose up -d

# Try Craft CMS 3 (install)
if [ ! -d "site/config" ]; then
  $my_dir/../craft/install.bash
fi

echo
echo "  ${GREEN}SUCCESS${NC} Done"
echo

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
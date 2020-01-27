#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Deploy"
echo

ok=false

# try gitlab-ci
if [ -f ".gitlab-ci.yml" ]; then
  repository=$(git config --get remote.origin.url)
  echo "  → ${BOLD}GitLab Continuous Integration (CI) & Continuous Delivery (CD)${NC}"
  echo "    Configuration: ./.gitlab-ci.yml"
  echo "    Repository: $repository"
  echo "    Official Documentation: https://about.gitlab.com/product/continuous-integration/"

  ok=true
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

if [ "$ok" = true ]; then
  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
else
  echo
  echo "  ${RED}ERROR${NC} Could not find a method to execute command"
  echo
fi

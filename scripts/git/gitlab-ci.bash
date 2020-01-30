#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} GitLab Continuous Integration (CI) & Continuous Delivery (CD)"
echo

repository=$(git config --get remote.origin.url)

echo "    Configuration: ./.gitlab-ci.yml"
echo "    Repository: $repository"
echo "    Official Documentation: https://about.gitlab.com/product/continuous-integration/"

echo
echo "  ${GREEN}SUCCESS${NC} Done"
echo

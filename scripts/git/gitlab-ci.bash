#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK GitLab Continuous Integration (CI) & Continuous Delivery (CD)"
echo

repository=$(git config --get remote.origin.url)

echo "    Configuration: ./.gitlab-ci.yml"
echo "    Repository: $repository"
echo "    Official Documentation: https://about.gitlab.com/product/continuous-integration/"

echo
echo "$I18N_SUCCESS Done"
echo

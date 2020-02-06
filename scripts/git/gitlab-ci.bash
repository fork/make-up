#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Git' → GitLab Continuous Integration (CI) & Continuous Delivery (CD)"
echo

if [ "$IDENT_GITLAB_CI" = true ]; then
  repository=$(git config --get remote.origin.url)

  echo "    Configuration: ./.gitlab-ci.yml"
  if [ -n "$repository" ]; then
    echo "    Repository: $repository"
  else
    echo "    Repository: not found"
  fi
  echo "    Official Documentation: https://about.gitlab.com/product/continuous-integration/"
  echo
  echo "$I18N_SUCCESS Done"
  echo
else
  echo
  echo "$I18N_ERROR Could not find ./.gitlab-ci.yml"
  echo
fi


#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Git' → GitLab Continuous Integration (CI) & Continuous Delivery (CD)"
echo

if [ "$IDENT_GITLAB_CI" = true ]; then
  repository=$(git config --get remote.origin.url)
  domain="${repository[@]//://}"
  domain="${domain[@]//.git/}"
  domain="${domain[@]//git@/}"
  domain="https://${domain}"
  pipelines="${domain}/-/pipelines"

  echo "  → ${BOLD}Configuration${NC}"
  echo "    ./.gitlab-ci.yml"
  echo

  if [ -n "$repository" ]; then
    echo "  → ${BOLD}Repository${NC}"
    echo "    $domain"
    echo
    echo "  → ${BOLD}Pipelines${NC}"
    echo "    $pipelines"
    echo
  else
    echo "    Repository: not found"
  fi
  echo "    Official Documentation of GitLab CI: https://about.gitlab.com/product/continuous-integration/"
  echo
  echo "$I18N_SUCCESS Done"
  echo
else
  echo
  echo "$I18N_ERROR Could not find ./.gitlab-ci.yml"
  echo
fi


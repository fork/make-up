#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Git' → Git-ftp"
echo

if [ "$IDENT_GIT_FTP" = true ]; then
  echo "    Configuration: ./.git-ftp-config"
  echo "    Official Documentation: https://github.com/git-ftp/git-ftp"

  echo
  echo "$I18N_SUCCESS Done"
  echo
else
  echo
  echo "$I18N_ERROR Could not find ./.git-ftp-config"
  echo
fi

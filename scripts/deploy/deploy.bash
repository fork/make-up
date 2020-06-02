#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK Deploy"
echo

ok=false

# try gitlab-ci
if [ "$IDENT_GITLAB_CI" = true ]; then
  $my_dir/../git/gitlab-ci.bash

  ok=true
fi

# try git-ftp
if [ "$IDENT_GIT_FTP" = true ]; then
  $my_dir/../git/git-ftp.bash
  
  ok=true
fi

# try '$ npm run deploy' from package.json
if [ -f "package.json" ]; then
  if grep -q \"deploy\" "package.json"; then
    # yarn
    if [ "$IDENT_YARN" = true ]; then
      manager="yarn"
    fi 
    
    # npm
    if [ "$IDENT_NPM" = true ]; then
      manager="npm run"
    fi 

    echo
    echo "${I18N_INFO} Task found in ./package.json"
    echo 
    echo "  → deploy"

    if [ -n "$manager" ]; then
      echo

      echo -n "$I18N_QUESTION Run '$ $manager deploy'? (y/n)"
      read answer
      echo
    
      if [ "$answer" != "${answer#[Yy]}" ]; then
        echo "$I18N_TASK Run '$ $manager deploy'"
        echo 

        $manager deploy

        echo
        echo "$I18N_SUCCESS Success"
        echo
      else
        echo "$I18N_WARNING Skipped '$ $manager deploy'"
        echo
      fi
    fi

    ok=true
  fi
fi

# more-make-up
MORE_MAKE_UP="${0/make-up/more-make-up}"
if [ -f "$MORE_MAKE_UP" ]; then
  echo
  echo "$I18N_TASK Run more Make-up from $MORE_MAKE_UP"
  echo

  $MORE_MAKE_UP

  echo
  echo "$I18N_SUCCESS Done"
  echo

  ok=true
fi

if [ "$ok" = true ]; then
  echo
  echo "$I18N_SUCCESS Done"
  echo
else
  echo
  echo "$I18N_ERROR Could not find a method to execute command"
  echo
fi

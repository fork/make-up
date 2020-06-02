#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK Build"
echo

ok=false

# try task 'build' from package.json
if [ -f "package.json" ]; then
  if grep -q \"build\" "package.json"; then
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
    echo "  → build"

    if [ -n "$manager" ]; then
      echo

      echo -n "$I18N_QUESTION Run '$ $manager build'? (y/n)"
      read answer
      echo
    
      if [ "$answer" != "${answer#[Yy]}" ]; then
        echo "$I18N_TASK Run '$ $manager build'"
        echo 

        $manager build

        echo
        echo "$I18N_SUCCESS Success"
        echo
      else
        echo "$I18N_WARNING Skipped '$ $manager build'"
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

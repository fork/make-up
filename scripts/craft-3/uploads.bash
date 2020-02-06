#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Craft 3' → Uploads directory"
echo

ok=false

if [ ! "$IDENT_CRAFT_3" = true ]; then 
  # params
  UPLOADS=null

  # create uploads directory from E_DEV_UPLOADS
  if [ ! -z "$E_DEV_UPLOADS" ]; then
    UPLOADS=$E_DEV_UPLOADS
  fi

  # create uploads directory from INITIAL_UPLOADS
  if [ -z "$E_DEV_UPLOADS" ]; then
    UPLOADS=$INITIAL_UPLOADS
  fi

  # create directory
  mkdir -p $UPLOADS

  # test if directory now exists
  if [ -d "$UPLOADS" ]; then
    YOUR_GIT_IGNORE=.gitignore

    echo
    echo "$I18N_SUCCESS Your Craft Uploads are here: $UPLOADS"
    echo
    echo "$I18N_TASK Add $UPLOADS to $YOUR_GIT_IGNORE"
    echo

    # check if $UPLOADS is already in $YOUR_GIT_IGNORE
    if grep -Fxq "$UPLOADS" $YOUR_GIT_IGNORE; then
      echo
      echo "$I18N_SUCCESS Done"
      echo
    else
      printf "\n$UPLOADS" >>$YOUR_GIT_IGNORE

      echo
      echo "$I18N_SUCCESS Done"
      echo
    fi
  else
    echo
    echo "$I18N_ERROR Could not create directory $UPLOADS"
    echo
  fi

  ok=true
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
#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Craft CMS 3: Uploads directory"
echo

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

mkdir -p $UPLOADS

if [ -d "$UPLOADS" ]; then
  echo
  echo "  ${GREEN}Success${NC} Your Craft Uploads are here: $UPLOADS"
  echo

  YOUR_GIT_IGNORE=.gitignore

  echo
  echo "  ${BLUE}TASK${NC} Add $UPLOADS to $YOUR_GIT_IGNORE"
  echo

  # check if $UPLOADS is already in $YOUR_GIT_IGNORE
  if grep -Fxq "$UPLOADS" $YOUR_GIT_IGNORE; then
    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  else
    printf "\n$UPLOADS" >>$YOUR_GIT_IGNORE

    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  fi
else
  echo
  echo "  ${RED}ERROR${NC} Could not create directory $UPLOADS"
  echo
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
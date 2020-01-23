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
else
  echo
  echo "  ${RED}ERROR${NC} Could not create directory $UPLOADS"
  echo
fi

#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Create uploads directory"
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

echo "  ${GREEN}SUCCESS${NC} Uploads path: $UPLOADS"
echo
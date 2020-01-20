#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Synchronize database and uploads from environment ${GREEN}production${NC} to ${WHITE}dev${NC}"
echo

echo
echo "  ${BLUE}TASK${NC} Get database from ${GREEN}production${NC}"
echo

# todo: try mysql

# dump database
ssh -T "$E_PRODUCTION_SSH_USER@$E_PRODUCTION_SSH_HOST" 'mysqldump -u' "$E_PRODUCTION_DB_USER"' -p'"$E_PRODUCTION_DB_PASS"' '"$E_PRODUCTION_DB_NAME"' | gzip -f > '"$E_PRODUCTION_PROJECT_HOME"'/'"$E_PRODUCTION_DB_DUMP_NAME"

# copy database dump from production to dev
scp "$E_PRODUCTION_SSH_USER@$E_PRODUCTION_SSH_HOST":$E_PRODUCTION_PROJECT_HOME/$E_PRODUCTION_DB_DUMP_NAME $E_PRODUCTION_DB_DUMP_NAME

# remove dump from production
ssh -T "$E_PRODUCTION_SSH_USER@$E_PRODUCTION_SSH_HOST" 'rm' "$E_PRODUCTION_PROJECT_HOME"'/'"$E_PRODUCTION_DB_DUMP_NAME"

if [ -f "$E_PRODUCTION_DB_DUMP_NAME" ]; then
  # restore database
  $my_dir/../backup/restore.bash $E_PRODUCTION_DB_DUMP_NAME

  # remove dump
  rm $E_PRODUCTION_DB_DUMP_NAME

  echo
  echo "  ${GREEN}SUCCESS${NC} Synchronized database"
  echo
else
  echo
  echo "  ${RED}ERROR${NC} No file found that could be used to restore database"
  echo
fi

echo
echo "  ${BLUE}TASK${NC} Synchronize uploads"
echo

# sync uploads
rsync -F -L -a -z -e ssh $E_PRODUCTION_SSH_USER@$E_PRODUCTION_SSH_HOST:$E_PRODUCTION_UPLOADS/* $E_DEV_UPLOADS --delete-after --progress

echo
echo "  ${GREEN}SUCCESS${NC} Synchronized uploads to $E_DEV_UPLOADS"
echo

#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Synchronize database and uploads from environment ${GREEN}staging${NC} to ${WHITE}dev${NC}"
echo

echo
echo "  ${BLUE}TASK${NC} Get database from ${GREEN}staging${NC}"
echo

E_STAGING_DB_DUMP_NAME=staging.sql.gz

# check if all neccesary information is given
if 
  [ ! -n "$E_STAGING_SSH_USER" ] || 
  [ ! -n "$E_STAGING_SSH_HOST" ] || 
  [ ! -n "$E_STAGING_DB_USER" ] || 
  [ ! -n "$E_STAGING_DB_PASS" ] || 
  [ ! -n "$E_STAGING_DB_NAME" ] ||  
  [ ! -n "$E_STAGING_PROJECT_HOME" ]; then
  echo
  echo "  ${RED}ERROR${NC} Some information is missing in your ${WHITE}.env${NC} file (@see below)."
  echo
  echo "  → E_STAGING_SSH_USER=$E_STAGING_SSH_USER"
  echo "  → E_STAGING_SSH_HOST=$E_STAGING_SSH_HOST"
  echo "  → E_STAGING_DB_USER=$E_STAGING_DB_USER"
  echo "  → E_STAGING_DB_PASS=$E_STAGING_DB_PASS"
  echo "  → E_STAGING_DB_NAME=$E_STAGING_DB_NAME"
  echo "  → E_STAGING_PROJECT_HOME=$E_STAGING_PROJECT_HOME"
else
  # dump database
  ssh -T "$E_STAGING_SSH_USER@$E_STAGING_SSH_HOST" 'mysqldump -u' "$E_STAGING_DB_USER"' -p'"$E_STAGING_DB_PASS"' '"$E_STAGING_DB_NAME"' | gzip -f > '"$E_STAGING_PROJECT_HOME"'/'"$E_STAGING_DB_DUMP_NAME"

  # copy database dump from staging to dev
  scp "$E_STAGING_SSH_USER@$E_STAGING_SSH_HOST":$E_STAGING_PROJECT_HOME/$E_STAGING_DB_DUMP_NAME $E_STAGING_DB_DUMP_NAME

  # remove dump from staging
  ssh -T "$E_STAGING_SSH_USER@$E_STAGING_SSH_HOST" 'rm' "$E_STAGING_PROJECT_HOME"'/'"$E_STAGING_DB_DUMP_NAME"

  if [ -f "$E_STAGING_DB_DUMP_NAME" ]; then
    # restore database
    $my_dir/../backup/restore.bash $E_STAGING_DB_DUMP_NAME

    # remove dump
    rm $E_STAGING_DB_DUMP_NAME

    echo
    echo "  ${GREEN}SUCCESS${NC} Synchronized database"
    echo
  else
    echo
    echo "  ${RED}ERROR${NC} No file found that could be used to restore database"
    echo
  fi
fi

echo
echo "  ${BLUE}TASK${NC} Synchronize uploads"
echo

# check if all neccesary information is given
if 
  [ ! -n "$E_STAGING_SSH_USER" ] || 
  [ ! -n "$E_STAGING_SSH_HOST" ] || 
  [ ! -n "$E_STAGING_UPLOADS" ] || 
  [ ! -n "$E_DEV_UPLOADS" ]; then
  echo
  echo "  ${RED}ERROR${NC} Some information is missing in your ${WHITE}.env${NC} file (@see below)."
  echo
  echo "  → E_STAGING_SSH_USER=$E_STAGING_SSH_USER"
  echo "  → E_STAGING_SSH_HOST=$E_STAGING_SSH_HOST"
  echo "  → E_STAGING_UPLOADS=$E_STAGING_UPLOADS"
  echo "  → E_DEV_UPLOADS=$E_DEV_UPLOADS"
else
  # create dir
  mkdir -p $E_DEV_UPLOADS

  # sync uploads
  rsync -F -L -a -z -e ssh $E_STAGING_SSH_USER@$E_STAGING_SSH_HOST:$E_STAGING_UPLOADS/* $E_DEV_UPLOADS --delete-after --progress
  
  echo
  echo "  ${GREEN}SUCCESS${NC} Synchronized uploads to ./$E_DEV_UPLOADS (There may be additional output above)"
  echo
fi


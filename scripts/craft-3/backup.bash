#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Craft 3' → Dump database from docker image"
echo

ok=false

if [ "$IDENT_DOCKER" = true ]; then
  NOW=$(date +"%Y-%m-%d_%H-%M")
  DUMP_DIR=backups
  DUMP_NAME=craft_$NOW

  # check if all neccesary information is given
  if
    [ ! -n "$DB_USER" ] ||
      [ ! -n "$DB_SERVER" ] ||
      [ ! -n "$DB_DATABASE" ] ||
      [ ! -n "$DB_PASSWORD" ]
  then
    echo
    echo "$I18N_ERROR Some information is missing in your ${WHITE}.env${NC} file (@see below)."
    echo
    echo "  → DB_USER=$DB_USER"
    echo "  → DB_SERVER=$DB_SERVER"
    echo "  → DB_DATABASE=$DB_DATABASE"
    echo "  → DB_PASSWORD=$DB_PASSWORD"
  else
    # create dir
    mkdir -p $DUMP_DIR
    docker exec -i $(docker-compose ps -q db) mysqldump -u$DB_USER -p$DB_PASSWORD -h$DB_SERVER $DB_DATABASE | gzip >$DUMP_DIR/$DUMP_NAME.sql.gz
    
    if [ -f "$DUMP_DIR/$DUMP_NAME.sql.gz" ]; then
      echo
      echo "$I18N_INFO Created dump: $DUMP_DIR/$DUMP_NAME.sql.gz"
      echo
    else
      echo
      echo "$I18N_ERROR Could not find $DUMP_DIR/$DUMP_NAME.sql.gz"
      echo
    fi
  fi

  ok=true
else
  echo
  echo "$I18N_ERROR Docker is required to run this command"
  echo  
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

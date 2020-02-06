#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Craft 3' → Enter database shell in docker container"
echo

ok=false

if [ -d "docker" ]; then
  DUMP_NAME=$1
  BACKUPS_DIR=backups

  # check if all neccesary information is given
  if
    [ ! -n "$DB_DRIVER" ] ||
      [ ! -n "$DB_USER" ] ||
      [ ! -n "$DB_SERVER" ] ||
      [ ! -n "$DB_DATABASE" ] ||
      [ ! -n "$DB_PASSWORD" ]
  then
    echo
    echo "$I18N_ERROR Some information is missing in your ${WHITE}.env${NC} file (@see below)."
    echo
    echo "  → DB_DRIVER=$DB_DRIVER"
    echo "  → DB_USER=$DB_USER"
    echo "  → DB_SERVER=$DB_SERVER"
    echo "  → DB_DATABASE=$DB_DATABASE"
    echo "  → DB_PASSWORD=$DB_PASSWORD"
  else
    if [ -z "$DUMP_NAME" ]; then
      # restore latest
      DUMP_NAME=$BACKUPS_DIR/$(ls -t1 $BACKUPS_DIR/ | head -n 1)
      echo
      echo "  → ${BOLD}Restoring latest dump${NC}"
      echo "    $DUMP_NAME"
    else
      # restore from DUMP_NAME
      echo
      echo "  → ${BOLD}Restoring dump${NC}"
      echo "    $DUMP_NAME"
    fi

    # create temporary copy from DUMP_NAME
    gzip -d -c $DUMP_NAME >temp.sql.tmp

    # import
    docker exec -i $(docker-compose ps -q db) $DB_DRIVER -u$DB_USER -p$DB_PASSWORD -h$DB_SERVER $DB_DATABASE <temp.sql.tmp

    # remove temporary files
    rm temp.sql.tmp

    echo
    echo "$I18N_SUCCESS Done"
    echo
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

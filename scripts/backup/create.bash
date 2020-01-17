#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Backup data"
echo

ok=false

# try docker
if [ -d "docker" ]; then
  echo
  echo "  ${BLUE}TASK${NC} 🐳 Dump database from docker image"
  echo

  NOW=$(date +"%Y-%m-%d_%H-%M")
  DUMP_DIR=backups
  DUMP_NAME=craft_$NOW

  # create dir
  mkdir -p $DUMP_DIR
  docker exec -i $(docker-compose ps -q db) mysqldump -u$DB_USER -p$DB_PASSWORD -h$DB_SERVER $DB_DATABASE | gzip > $DUMP_DIR/$DUMP_NAME.sql.gz
  ok=true

  if [ -f "$DUMP_DIR/$DUMP_NAME.sql.gz" ]; then
    echo
    echo "  ${GREEN}SUCCESS${NC} Created dump: $DUMP_DIR/$DUMP_NAME.sql.gz"
    echo
  else
    echo
    echo "  ${RED}ERROR${NC} Could not find $DUMP_DIR/$DUMP_NAME.sql.gz"
    echo
  fi
fi

if [ "$ok" = true ]; then
  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
else
  echo
  echo "  ${RED}ERROR${NC} Could not find a method to execute command"
  echo
fi
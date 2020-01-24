#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} 🐳 Dump database from docker image"
echo

NOW=$(date +"%Y-%m-%d_%H-%M")
DUMP_DIR=backups
DUMP_NAME=craft_$NOW

# create dir
mkdir -p $DUMP_DIR
docker exec -i $(docker-compose ps -q db) mysqldump -u$DB_USER -p$DB_PASSWORD -h$DB_SERVER $DB_DATABASE | gzip >$DUMP_DIR/$DUMP_NAME.sql.gz

if [ -f "$DUMP_DIR/$DUMP_NAME.sql.gz" ]; then
  echo
  echo "  ${GREEN}SUCCESS${NC} Created dump: $DUMP_DIR/$DUMP_NAME.sql.gz"
  echo
else
  echo
  echo "  ${RED}ERROR${NC} Could not find $DUMP_DIR/$DUMP_NAME.sql.gz"
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
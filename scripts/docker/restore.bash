#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} 🐳 Enter database shell in docker container"
echo

DUMP_NAME=$1
BACKUPS_DIR=backups

if [ -z "$DUMP_NAME" ]; then
  # restore latest
  DUMP_NAME=$BACKUPS_DIR/$(ls -t1 backups/ | head -n 1)
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
gzip -d -c $DUMP_NAME >craft-temp.sql.tmp

# import
docker exec -i $(docker-compose ps -q db) $DB_DRIVER -u$DB_USER -p$DB_PASSWORD -h$DB_SERVER $DB_DATABASE <craft-temp.sql.tmp

# remove temporary files
rm craft-temp.sql.tmp

echo
echo "  ${GREEN}SUCCESS${NC} Done"
echo

#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK 'Craft 3' → Enter database shell"
echo

ok=false

if [ "$IDENT_DOCKER" = true ]; then
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
    docker-compose exec db $DB_DRIVER -u$DB_USER -p$DB_PASSWORD -h$DB_SERVER $DB_DATABASE
  fi

  echo
  echo "$I18N_SUCCESS Done"
  echo

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

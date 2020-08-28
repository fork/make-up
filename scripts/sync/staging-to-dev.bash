#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "$I18N_TASK Synchronize database and uploads from environment ${GREEN}staging${NC} to ${WHITE}dev${NC}"
echo

E_STAGING_DB_DUMP_NAME=staging.sql.gz

# check if all neccesary information is given
if
  [ ! -n "$E_STAGING_SSH_USER" ] ||
	[ ! -n "$E_STAGING_SSH_HOST" ]
then
  echo
  echo "$I18N_ERROR Some information is missing in your ${WHITE}.env${NC} file (@see below)."
  echo
  echo "  → E_STAGING_SSH_USER=$E_STAGING_SSH_USER"
  echo "  → E_STAGING_SSH_HOST=$E_STAGING_SSH_HOST"
else
	echo "$I18N_INFO Credentials found in $ENV_FILE"
	echo
	echo "  → E_STAGING_SSH_USER=$E_STAGING_SSH_USER"
	echo "  → E_STAGING_SSH_HOST=$E_STAGING_SSH_HOST"

	# test ssh connection
	status=$(ssh -o ConnectTimeout=5 $E_STAGING_SSH_USER@$E_STAGING_SSH_HOST echo ok)

	if [[ "$status" == *ok ]]; then
		echo
		echo "$I18N_TASK Get database from ${GREEN}staging${NC}"
		echo

		# check if all neccesary information is given
		if
				[ ! -n "$E_STAGING_DB_USER" ] ||
				[ ! -n "$E_STAGING_DB_PASS" ] ||
				[ ! -n "$E_STAGING_DB_NAME" ] ||
				[ ! -n "$E_STAGING_DB_DUMP_NAME" ] ||
				[ ! -n "$E_STAGING_PROJECT_HOME" ]
		then
			echo
			echo "$I18N_ERROR Some information is missing in your ${WHITE}.env${NC} file (@see below)."
			echo
			echo "  → E_STAGING_DB_USER=$E_STAGING_DB_USER"
			echo "  → E_STAGING_DB_PASS=$E_STAGING_DB_PASS"
			echo "  → E_STAGING_DB_NAME=$E_STAGING_DB_NAME"
			echo "  → E_STAGING_DB_DUMP_NAME=$E_STAGING_DB_DUMP_NAME"
			echo "  → E_STAGING_PROJECT_HOME=$E_STAGING_PROJECT_HOME"
		else
			echo "$I18N_INFO Credentials found in $ENV_FILE"
			echo
			echo "  → E_STAGING_DB_USER=$E_STAGING_DB_USER"
			echo "  → E_STAGING_DB_PASS=$E_STAGING_DB_PASS"
			echo "  → E_STAGING_DB_NAME=$E_STAGING_DB_NAME"
			echo "  → E_STAGING_DB_DUMP_NAME=$E_STAGING_DB_DUMP_NAME"
			echo "  → E_STAGING_PROJECT_HOME=$E_STAGING_PROJECT_HOME"
			echo

			# dump database
			if [[ -z $E_STAGING_DOCKER_COMPOSE_FILE || -z $E_STAGING_DOCKER_COMPOSE_SERVICE ]]; then
				echo "$I18N_INFO Dumping from mysql"
				ssh -T "$E_STAGING_SSH_USER@$E_STAGING_SSH_HOST" 'mysqldump -u' "$E_STAGING_DB_USER"' -p'"$E_STAGING_DB_PASS"' '"$E_STAGING_DB_NAME"' | gzip -f > '"$E_STAGING_PROJECT_HOME"'/'"$E_STAGING_DB_DUMP_NAME"
			else
				echo "$I18N_INFO Dumping from docker container mysql"
				ssh -T "$E_STAGING_SSH_USER@$E_STAGING_SSH_HOST" 'docker-compose -f '"$E_STAGING_DOCKER_COMPOSE_FILE"' exec -T '"$E_STAGING_DOCKER_COMPOSE_SERVICE"' mysqldump -u'"$E_STAGING_DB_USER"' -p'\""$E_STAGING_DB_PASS"\"' '"$E_STAGING_DB_NAME"' | gzip -f > '"$E_STAGING_PROJECT_HOME"'/'"$E_STAGING_DB_DUMP_NAME"''
			fi

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
				echo "$I18N_SUCCESS Synchronized database"
				echo
			else
				echo
				echo "$I18N_ERROR No file found that could be used to restore database"
				echo
			fi
		fi

		echo
		echo "$I18N_TASK Synchronize uploads"
		echo

		# check if all neccesary information is given
		if
				[ ! -n "$E_STAGING_UPLOADS" ] ||
				[ ! -n "$E_DEV_UPLOADS" ]
		then
			echo
			echo "$I18N_ERROR Some information is missing in your ${WHITE}.env${NC} file (@see below)."
			echo
			echo "  → E_STAGING_UPLOADS=$E_STAGING_UPLOADS"
			echo "  → E_DEV_UPLOADS=$E_DEV_UPLOADS"
		else
			echo "$I18N_INFO Credentials found in $ENV_FILE"
			echo
			echo "  → E_STAGING_UPLOADS=$E_STAGING_UPLOADS"
			echo "  → E_DEV_UPLOADS=$E_DEV_UPLOADS"
			echo

			# create dir
			mkdir -p $E_DEV_UPLOADS

			# sync uploads
			rsync -F -L -a -z -e ssh $E_STAGING_SSH_USER@$E_STAGING_SSH_HOST:$E_STAGING_UPLOADS/* $E_DEV_UPLOADS --delete-after --progress

			echo
			echo "$I18N_SUCCESS Synchronized uploads to ./$E_DEV_UPLOADS (There may be additional output above)"
			echo
		fi
	else
		echo
		echo "$I18N_ERROR SSH connection could not be established"
		echo
	fi
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

#!/bin/sh

# todo WIP

PROJECT=`php -r "echo dirname(dirname(dirname(realpath('$0'))));"`
STAGED_FILES_CMD=`git diff --cached --name-only --diff-filter=ACMR HEAD | grep \\\\.php`

# Determine if a file list is passed
if [ "$#" -eq 1 ]
then
	oIFS=$IFS
	IFS='
	'
	SFILES="$1"
	IFS=$oIFS
fi
SFILES=${SFILES:-$STAGED_FILES_CMD}

for FILE in $SFILES
do
	php -l -d display_errors=0 $PROJECT/$FILE
	if [ $? != 0 ]
	then
		echo "Fix the error before commit."
		exit 1
	fi
	FILES="$FILES $PROJECT/$FILE"
done

if [ "$FILES" != "" ]
then
	echo "Running Code Sniffer..."
	./site/vendor/bin/phpcbf --standard=PSR2 --encoding=utf-8 -n -p $FILES
	# Exit Code 2 means there were unfixable errors, 1 means all errors were fixed, 0 means no errors found
	case $? in
		1)
			echo "PHPCBF fixed some errors. Adding the fixed files again..."
			git add $FILES
			;;
		2)
			echo "PHPCBF couldn't fix all errors. Please fix them manually before commit."
			exit 1
			;;
	esac
fi

exit $?

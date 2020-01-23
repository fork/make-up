#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Craft CMS 3: Setup Environment"
echo

file="site/.env"
file_example="site/.env.example"
file_backup="site/.env.original"

# prepare injections
injections() {
cat << EOF >> $file

# The following lines are initially auto-generated by '$ make envfile'
# The following environment variables are used within ./../Makefile, that is why we used a prefix like "E_"

# Environment dev on localhost
E_DEV_UPLOADS=$INITIAL_UPLOADS

# Environment 'staging' on dev.4rk.de
E_STAGING_SSH_USER=USER
E_STAGING_SSH_HOST=HOST
E_STAGING_PROJECT_HOME=PROJECT_HOME
E_STAGING_DB_PASS=PASSWORD
E_STAGING_DB_USER=DB_USER
E_STAGING_DB_NAME=DB_NAME
E_STAGING_UPLOADS=UPLOADS

# Environment 'production' on production server;
E_PRODUCTION_SSH_USER=USER
E_PRODUCTION_SSH_HOST=HOST
E_PRODUCTION_PROJECT_HOME=PROJECT_HOME
E_PRODUCTION_DB_PASS=PASSWORD
E_PRODUCTION_DB_USER=DB_USER
E_PRODUCTION_DB_NAME=DB_NAME
E_PRODUCTION_UPLOADS=UPLOADS

# Default Site URL
DEFAULT_SITE_URL="http://$FOLDER_NAME.localhost"
EOF
}

if [ -f "$file" ]; then
  echo
  echo "  ${YELLOW}WARNING${NC} Existing $file found, creating backup"
  echo

  cp $file $file_backup

  if [ -f "$file_backup" ]; then
    echo
    echo "  ${GREEN}Success${NC} Created $file_backup from $file"
    echo
  else
    echo
    echo "  ${RED}ERROR${NC} Could not create $file_backup from $file"
    echo
  fi
fi

echo
echo "  ${BLUE}TASK${NC} Create $file from $file_example"
echo

if [ -f "$file_example" ]; then
  # create new .env file
  cp $file_example $file
  
  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
else 
  echo
  echo "  ${RED}ERROR${NC} $file_example not found. Craft installation is corrupted."
  echo
fi

if [ -f "$file" ]; then
  echo
  echo "  ${BLUE}TASK${NC} Generating a security key in $file"

  # Generating a security key
  ./site/craft setup/security-key

  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
  
  echo
  echo "  ${BLUE}TASK${NC} Make injections to $file"
  echo

  # make injections
  injections

  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
  
  echo
  echo "  ${BLUE}TASK${NC} Make replacements in $file"
  echo

  # fill in data for environment: dev
  sed 's#DB_SERVER="localhost"#DB_SERVER="db"#' $file > tmp && mv tmp $file; \
  sed 's#DB_DATABASE=""#DB_DATABASE="craft"#' $file > tmp && mv tmp $file; \
  sed 's#DB_USER="root"#DB_USER="craft"#' $file > tmp && mv tmp $file; \
  sed 's#DB_PASSWORD=""#DB_PASSWORD="craft"#' $file > tmp && mv tmp $file; \
  sed 's#DB_TABLE_PREFIX=""#DB_TABLE_PREFIX="craft"#' $file > tmp && mv tmp $file; \

  # Ask for a value
  VARIABLE_NAME="E_DEV_UPLOADS"
  DEFAULT_VALUE="site/web/uploads"
  QUESTION="Set relative path to uploads for ${WHITE}dev${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi

  # Ask for a value
  VARIABLE_NAME="E_STAGING_SSH_USER"
  DEFAULT_VALUE="USER"
  QUESTION="Set SSH user for ${YELLOW}staging${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi
  
  # Ask for a value
  VARIABLE_NAME="E_STAGING_SSH_HOST"
  DEFAULT_VALUE="HOST"
  QUESTION="Set SSH host for ${YELLOW}staging${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi

  # Ask for a value
  VARIABLE_NAME="E_STAGING_PROJECT_HOME"
  DEFAULT_VALUE="PROJECT_HOME"
  QUESTION="Set path to project home for ${YELLOW}staging${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi

  # Ask for a value
  VARIABLE_NAME="E_STAGING_UPLOADS"
  DEFAULT_VALUE="UPLOADS"
  QUESTION="Set absolute path to uploads for ${YELLOW}staging${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi
  
  # Ask for a value
  VARIABLE_NAME="E_STAGING_DB_PASS"
  DEFAULT_VALUE="PASSWORD"
  QUESTION="Set database password for ${YELLOW}staging${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi

  # Ask for a value
  VARIABLE_NAME="E_STAGING_DB_USER"
  DEFAULT_VALUE="DB_USER"
  QUESTION="Set database user for ${YELLOW}staging${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi
  
  # Ask for a value
  VARIABLE_NAME="E_STAGING_DB_NAME"
  DEFAULT_VALUE="DB_NAME"
  QUESTION="Set database name for ${YELLOW}staging${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi

  # Ask for a value
  VARIABLE_NAME="E_PRODUCTION_SSH_USER"
  DEFAULT_VALUE="USER"
  QUESTION="Set SSH user for ${GREEN}production${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi
  
  # Ask for a value
  VARIABLE_NAME="E_PRODUCTION_SSH_HOST"
  DEFAULT_VALUE="HOST"
  QUESTION="Set SSH host for ${GREEN}production${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi

  # Ask for a value
  VARIABLE_NAME="E_PRODUCTION_PROJECT_HOME"
  DEFAULT_VALUE="PROJECT_HOME"
  QUESTION="Set path to project home for ${GREEN}production${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi

  # Ask for a value
  VARIABLE_NAME="E_PRODUCTION_UPLOADS"
  DEFAULT_VALUE="UPLOADS"
  QUESTION="Set absolute path to uploads for ${GREEN}production${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi
  
  # Ask for a value
  VARIABLE_NAME="E_PRODUCTION_DB_PASS"
  DEFAULT_VALUE="PASSWORD"
  QUESTION="Set database password for ${GREEN}production${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi

  # Ask for a value
  VARIABLE_NAME="E_PRODUCTION_DB_USER"
  DEFAULT_VALUE="DB_USER"
  QUESTION="Set database user for ${GREEN}production${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi
  
  # Ask for a value
  VARIABLE_NAME="E_PRODUCTION_DB_NAME"
  DEFAULT_VALUE="DB_NAME"
  QUESTION="Set database name for ${GREEN}production${NC}"

  echo "  ${MAGENTA}QUESTION${NC} $QUESTION (default: $DEFAULT_VALUE)"
  read -p "  " answer
  if [ -n "$answer" ]; then
    sed 's#'"$VARIABLE_NAME"'='"$DEFAULT_VALUE"'#'"$VARIABLE_NAME"'='"$answer"'#' $file > tmp && mv tmp $file; \
    echo
  fi

  # tell the user that he/she has to provide information for production
  echo "  ${WHITE}INFO${NC} Please visit $file and fill in missing information"

  echo
  echo "  ${GREEN}Success${NC} Done"
  echo
else
  echo
  echo "  ${RED}ERROR${NC} Could not create $file from $file_example"
  echo
fi

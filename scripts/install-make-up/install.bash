#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} 💄 Installing Make-up"
echo

ok=false

YOUR_GIT_IGNORE=../.gitignore
YOUR_ENV_FILE=../.env
OUR_MAKEFILE=./Makefile
YOUR_MAKEFILE=../Makefile

# create Makefile
if [ -f "$YOUR_MAKEFILE" ]; then
  echo
  echo "  ${YELLOW}WARNING${NC} $YOUR_MAKEFILE already exists"
  echo
else
  echo
  echo "  ${BLUE}TASK${NC} Create $YOUR_MAKEFILE"
  echo

  touch $YOUR_MAKEFILE

  if [ -f "$YOUR_MAKEFILE" ]; then
    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  else
    echo
    echo "  ${RED}ERROR${NC} Could not create find $YOUR_MAKEFILE"
    echo
  fi
fi

# create reference to make-up/Makefile
if [ -f "$YOUR_MAKEFILE" ]; then
  STRING="include make-up/Makefile"

  echo
  echo "  ${BLUE}TASK${NC} Create reference to $OUR_MAKEFILE in $YOUR_MAKEFILE"
  echo

  # check if $STRING is already in $YOUR_MAKEFILE
  grep -Fxq "$STRING" $YOUR_MAKEFILE

  if grep -Fxq "$STRING" $YOUR_MAKEFILE; then
    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  else
    printf "\n$STRING" >>$YOUR_MAKEFILE

    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  fi

  ok=true
fi

# create .env file
echo
echo "  ${BLUE}TASK${NC} Create $YOUR_ENV_FILE"
echo

touch $YOUR_ENV_FILE

if [ -f "$YOUR_ENV_FILE" ]; then
  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
else
  echo
  echo "  ${RED}ERROR${NC} Could not find $YOUR_ENV_FILE"
  echo
fi

# create .gitignore file
echo
echo "  ${BLUE}TASK${NC} Create $YOUR_GIT_IGNORE"
echo

touch $YOUR_GIT_IGNORE

if [ -f "$YOUR_GIT_IGNORE" ]; then
  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo

else
  echo
  echo "  ${RED}ERROR${NC} Could not find $YOUR_GIT_IGNORE"
  echo
fi

# add .env to .gitignore
echo
echo "  ${BLUE}TASK${NC} Add $YOUR_ENV_FILE to $YOUR_GIT_IGNORE"
echo

if [ -f "$YOUR_GIT_IGNORE" ]; then
  STRING=".env"

  # check if $STRING is already in $YOUR_GIT_IGNORE
  if grep -Fxq "$STRING" $YOUR_GIT_IGNORE; then
    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  else
    printf "\n$STRING" >>$YOUR_GIT_IGNORE

    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  fi
else
  echo
  echo "  ${RED}ERROR${NC} Could not find $YOUR_GIT_IGNORE"
  echo
fi

if [ "$ok" = true ]; then
  echo
  echo "  ${GREEN}SUCCESS${NC} 💋 Done"
  echo
else
  echo
  echo "  ${RED}ERROR${NC} Something went wrong. You should not be able to see this 😂"
  echo
fi

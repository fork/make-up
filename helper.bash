#!/bin/bash

# To load this helper in other bash scripts, copy and paste the following:

# --- start copy --- #

## load helper
#my_dir="$(dirname "$0")"
#source "$my_dir/helper.bash"
## execute other scripts from this file:
##   $my_dir/my-script.bash

# echo
# echo "$I18N_TASK My task"
# echo

# echo
# echo "$I18N_ERROR My error"
# echo

# echo
# echo "$I18N_SUCCESS Done"
# echo

# --- end copy --- #

# Text transforms
# @see https://linux.101hacks.com/ps1-examples/prompt-color-using-tput/
# Usage:
#   echo "A ${BOLD}solid${NC} statement."
BOLD=$(tput bold)
REV=$(tput rev)

# Colour
# @see https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# Usage:
#   echo "Roses are ${RED}red${NC}, violets are ${BLUE}blue${NC}."
RED=${REV}$(tput setaf 1)
GREEN=${REV}$(tput setaf 2)
YELLOW=${REV}$(tput setaf 3)
BLUE=${REV}$(tput setaf 4)
MAGENTA=${REV}$(tput setaf 5)
CYAN=${REV}$(tput setaf 6)
WHITE=${REV}$(tput setaf 7)
NC=$(tput sgr0) # No Color

# Define FOLDER_NAME
FOLDER_NAME=${PWD##*/}

# craft uploads directory
INITIAL_UPLOADS=site/web/uploads

# Make-Up commands
I18N_TASK="  ${BLUE}TASK${NC}"
I18N_SUCCESS="    ${GREEN}SUCCESS${NC}"
I18N_WARNING="    ${YELLOW}WARNING${NC}"
I18N_ERROR="    ${RED}ERROR${NC}"
I18N_INFO="    ${WHITE}INFO${NC}"
I18N_QUESTION="  ${MAGENTA}QUESTION${NC}"

# Software identifier

# Identify 'Craft 3'
if [ -d "site/config" ]; then
  IDENT_CRAFT_3=true
fi

# Identify 'Node modules'
if [ -d "node_modules" ]; then
  IDENT_NODE_MODULES=true
fi

# Identify 'Yarn'
if [ -f "yarn.lock" ]; then
  IDENT_YARN=true
fi

# Identify 'NPM'
if [ -f "package-lock.json" ]; then
  IDENT_NPM=true
fi

#!/bin/bash

# To load this helper in other bash scripts, copy and paste the following:

# --- start copy --- #

## load helper
#my_dir="$(dirname "$0")"
#source "$my_dir/helper.bash"
## execute other scripts from this file:
##   $my_dir/my-script.bash

# echo
# echo "  ${BLUE}TASK${NC} My task"
# echo

# echo
# echo "  ${RED}ERROR${NC} My error"
# echo

# echo
# echo "  ${GREEN}SUCCESS${NC} Done"
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
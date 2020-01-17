#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Start developing"
echo

# Docker
if [ -d "docker" ]; then 
  $my_dir/../docker/up.bash

  # Craft CMS 3 (install)
  if [ ! -d "site/config" ]; then
    echo
    echo "  ${BLUE}TASK${NC} Craft CMS"
    echo

    echo -n "Would you like to install Craft CMS 3 (y/n)? "
    read answer

    if [ "$answer" != "${answer#[Yy]}" ] ;then
      $my_dir/../craft/install.bash
    else
      echo
      echo "  ${YELLOW}WARNING${NC} Skipped"
      echo
    fi
    
    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  fi

  # Craft CMS (composer install)
  if [ -d "site" ]; then
    # check if we need a 'composer install' if craft is already included
    if [ ! -d "site/vendor" ]; then
      $my_dir/../craft/install-composer.bash
    fi
  fi
fi

# check if node modules are installed
if [ ! -d "node_modules" ]; then
  # is it yarn?
  if [ -f "yarn.lock" ]; then
    echo
    echo "  ${BLUE}TASK${NC} Install node modules with yarn"
    echo
    
    yarn install

    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  fi
  
  # is it npm?
  if [ -f "package-lock.json" ]; then
    echo
    echo "  ${BLUE}TASK${NC} Install node modules with npm"
    echo
    
    npm install

    echo
    echo "  ${GREEN}SUCCESS${NC} Done"
    echo
  fi
fi

# if node modules are installed, try '$ npm start'
if [ -d "node_modules" ]; then
  echo
  echo "  ${BLUE}TASK${NC} Running '$ npm start'"
  echo

  npm start --if-present

  echo
  echo "  ${GREEN}SUCCESS${NC} Done"
  echo
fi
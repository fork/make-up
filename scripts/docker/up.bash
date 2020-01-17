#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} Setting up docker"
echo

docker ps | grep -q nginx-proxy || $my_dir/proxyup.bash
docker-compose up -d

echo
echo "  ${GREEN}SUCCESS${NC} Done"
echo
#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/../../helper.bash"

echo
echo "  ${BLUE}TASK${NC} 🐳 Proxy Up"
echo

cd / && curl https://lab.fork.de/snippets/3/raw | docker-compose -f - up -d || docker start nginx-proxy

echo
echo "  ${GREEN}SUCCESS${NC} Done"
echo
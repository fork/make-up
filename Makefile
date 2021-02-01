################
# BEGIN Helper #
################

# Text transforms
# @see https://linux.101hacks.com/ps1-examples/prompt-color-using-tput/
# Usage:
#   echo "${REV}Foo${NC}"
BOLD := $(shell tput -Txterm bold)
REV := $(shell tput -Txterm rev)

# Colour
# @see https://gist.github.com/prwhite/8168133#gistcomment-2278355
# Usage:
#   echo "Roses are ${RED}red${NC}, violets are ${BLUE}blue${NC}."
RED := $(shell tput -Txterm setaf 1)
GREEN := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
BLUE := $(shell tput -Txterm setaf 4)
MAGENTA := $(shell tput -Txterm setaf 5)
CYAN := $(shell tput -Txterm setaf 6)
WHITE := $(shell tput -Txterm setaf 7)

# Reset text transoform or colour
# @see https://gist.github.com/prwhite/8168133#gistcomment-2278355
# Usage:
#   echo "${YELLOW}Foo${NC}"
NC := $(shell tput -Txterm sgr0)

# The help function enables us to use a special comment syntax (##).
# If we place a comment with ## one line above a Makefile method,
# it will be listed in `$ make help`.
# Usage:
#   ## This line will appear in `$ make help`
#   foo:
#	    echo bar

# Max char num in help function
TARGET_MAX_CHAR_NUM=20

## Shows this help
help:
	@echo ''
	@echo '  ${REV}${BLUE}TASK${NC} Listing all available commands'
	@echo ''
	@echo 'usage:'
	@echo '  ${YELLOW}make${NC} ${GREEN}<command>${NC}'
	@echo ''
	@echo 'commands:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${NC} ${GREEN}%s${NC}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@echo ''
	@echo ''
	@echo '  ${REV}${GREEN}SUCCESS${NC} Done'
	@echo ''

# Define ARGS so we can use arguments within a Makefile method: `$ make <method> args`
ARGS = $(filter-out $@,$(MAKECMDGOALS))

# Define PROJECT_NAME
FOLDER_NAME := $(notdir $(shell pwd))
MAKE_UP_FOLDER_NAME := $(notdir $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))
# Use git project name if available
GIT_PROJECT_NAME := $(shell basename `git rev-parse --show-toplevel 2>/dev/null` 2>/dev/null)
ifdef GIT_PROJECT_NAME
PROJECT_NAME := $(GIT_PROJECT_NAME)
else
PROJECT_NAME := $(FOLDER_NAME)
endif
export PROJECT_NAME

# Define path to HELPER_SCRIPTS
HELPER_SCRIPTS="$(MAKE_UP_FOLDER_NAME)/scripts"

# Define path to ENV_FILE
ORIGINAL_ENV_FILE=.env
ENV_FILE=$(ORIGINAL_ENV_FILE) # this can be overwritten in my-project/.env

# Export each variable from ORIGINAL_ENV_FILE.
# You may use each exported variable within each file in HELPER_SCRIPTS.
# List all available variables with: `$ make test`
ifneq ("$(wildcard $(ORIGINAL_ENV_FILE))","")
include $(ORIGINAL_ENV_FILE)
VARS:=$(shell sed -ne 's/ *\#.*$$//; /./ s/=.*$$// p' $(ORIGINAL_ENV_FILE) )
$(foreach v,$(VARS),$(eval $(shell echo export $(v)='$($(v))')))
endif

# Overwrite path to ENV_FILE
# If your ENV_FILE is not in the root directory (e.g. "my-project"), insert the following into "my-project/.env":
# ENV_FILE=path-to/.env

# Export each variable from ENV_FILE (because ORIGINAL_ENV_FILE may not match ENV_FILE at this point).
# You may use each exported variable within each file in HELPER_SCRIPTS.
# List all available variables with: `$ make test`
ifneq ("$(wildcard $(ENV_FILE))","")
include $(ENV_FILE)
VARS:=$(shell sed -ne 's/ *\#.*$$//; /./ s/=.*$$// p' $(ENV_FILE) )
$(foreach v,$(VARS),$(eval $(shell echo export $(v)='$($(v))')))
endif

##############
# END Helper #
##############

#################
# BEGIN methods #
#################

# Install make-up in project
install-make-up:
	@./scripts/install-make-up/install.bash

## Display project information
info:
	@./$(HELPER_SCRIPTS)/info/info.bash

## Initial project setup or an alias for 'start' if the project was already set up
up:
	@if [ ! -f ".env" ]; then \
		touch .env; \
		./$(HELPER_SCRIPTS)/start/start.bash; \
		./$(HELPER_SCRIPTS)/env/create.bash; \
		./$(HELPER_SCRIPTS)/uploads/create-dir.bash; \
		make help; \
		./$(HELPER_SCRIPTS)/frontend/node_modules.bash; \
	else \
		make start; \
	fi

## Start developing
start:
	@./$(HELPER_SCRIPTS)/start/start.bash
	@./$(HELPER_SCRIPTS)/frontend/node_modules.bash

## Stop developing
stop:
	@./$(HELPER_SCRIPTS)/stop/stop.bash

## Restart developing
restart:
	@make stop
	@make start

## Build
build:
	@./$(HELPER_SCRIPTS)/build/build.bash

## Run composer (Example: '$ make composer require foo/bar')
composer:
	@./$(HELPER_SCRIPTS)/composer/composer.bash $(ARGS)

## Enter shell
shell:
	@./$(HELPER_SCRIPTS)/shell/enter.bash

## Enter database shell
db-shell:
	@./$(HELPER_SCRIPTS)/db-shell/enter.bash

## Backup
backup:
	@./$(HELPER_SCRIPTS)/backup/create.bash

## Restore
restore:
	@./$(HELPER_SCRIPTS)/backup/restore.bash $(ARGS)

## Deploy
deploy:
	@./$(HELPER_SCRIPTS)/deploy/deploy.bash

## Synchronize from environment 'staging' to 'dev'
staging-to-dev:
	@./$(HELPER_SCRIPTS)/sync/staging-to-dev.bash

## Synchronize from environment 'production' to 'dev'
production-to-dev:
	@./$(HELPER_SCRIPTS)/sync/production-to-dev.bash

## Run tests
test:
	@./$(HELPER_SCRIPTS)/test/env.bash

###############
# END methods #
###############

# prevents arguments passed beeing evaluated as task names
%:
	@:

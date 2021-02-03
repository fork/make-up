# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v0.0.3.6] - 2021-02-03

## Changed

- Do not install Frontend dependencies on docker start

## [v0.0.3.5] - 2021-02-02

## Added

- "make env" command to (re-)build env config

## Fixed

- only setup .env if not already written (e.g. DEFAULT_SITE_URL is set)
- remove quotes in .env file variables
- run security-key task in docker container

## [v0.0.3.4] - 2021-02-01

## Fixed

- Fixed Quotes issue in Makefile

## [v0.0.3.3] - 2021-01-29

## Changed

- Changed craft docker image name to new release

## [v0.0.3.2] - 2020-08-28

## Added

- reworked make info and make deploy when displaying information about the git repository (tested with gitlab)
- completed task description for 'make up'
- ask user if staging and production environments shall be configured
- check ssh status only once
- .env replacements for craft 3.5

## Fixed

- fix error 'grep: package.json: No such file or directory' in task 'make deploy'
- change identify method for 'Craft 3'
- fix npm start not using yarn if available
- fix 'make up' task overwriting existing .env file
  fall back to 'make start' when .env exists
  to re-init project, delete .env before running 'make up'
- make status check more interactive in case the host is not in known_hosts yet
- don't show error if node_modules have been installed

## [v0.0.3.1] - 2020-05-29

## Added

- allow docker service for db sync
- define PROJECT_NAME based on git name if available/already existing project

## Fixed

- don't remove containers (and volumes) on stop

## [v0.0.3.0] - 2019-02-06

## Added

- Variables to identify certain software such as 'craft 3' or 'npm' in [helper.bash](helper.bash) that can be used in bash-scripts to prevent code from being executed if a specific software is installed - or not.
- Variables `I18N_INFO` and `I18N_QUESTION` in [helper.bash](helper.bash)
- Emojis in README 😀

## Fixed

- Scripts from _package.json_ being executed with _npm_ if _Yarn_ was used.
- Renamed 'Craft' into 'Craft 3' since there may be other versions to be included in future releases.
- Fixed some typos

## Removed

- Docker scripts are now integrated in [Craft 3](scripts/craft-3)

## [v0.0.2.2] - 2019-01-31

### Added

- _frontend/node_modules_ now tries `$ npm run dev` and `$ npm start` automatically
- Changed syntax `${BLUE}TASK${NC}` to `$I18N_TASK` (for 'task', 'success', 'warning', 'error')
- Craft now creates a reference to _site/.env_ in _.env_ automatically

### Fixed

- Typo
- Removed error message in `$ make up` caused by _env/create_

## [v0.0.2.1] - 2019-01-30

### Added

- v0.0.2 and v0.0.2.1 in changelog
- Craft CMS uploads will now be added automatically to your .gitignore

### Fixed

- Backwards compatibility with Craft CMS < 3.4.0

## [v0.0.2] - 2019-01-30

### Added

- Support for Craft CMS 3.4.1
- Added user feedback for missing data in .env files for database connections within docker

## [v0.0.1] - 2019-01-24

### Added

- This CHANGELOG file to hopefully serve as an evolving example of a
  standardized open source project CHANGELOG.
- README now contains a super cool image

[v0.0.3.0]: https://github.com/fork/make-up/compare/v0.0.2.2...v0.0.3.0
[v0.0.2.2]: https://github.com/fork/make-up/compare/v0.0.2.1...v0.0.2.2
[v0.0.2.1]: https://github.com/fork/make-up/compare/v0.0.2...v0.0.2.1
[v0.0.2]: https://github.com/fork/make-up/compare/v0.0.1...v0.0.2
[v0.0.1]: https://github.com/fork/make-up/tree/v0.0.1

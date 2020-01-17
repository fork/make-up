# Make-up

**Being a web developer is hard.** You often find yourself asking stuff like 'How do I setup this project?', 'What do I need to compile?', 'How do I deploy this?' and 'How do I get live data to my local machine?'.

Such things can really slow down the development process, because you need to know things – or at least read about it in the docs. Yeah.

By covering the necessary requirements for the development process automatically, Make-up leaves you more time for creativity.

No matter what project you are working on, no matter what software is used: Make-up makes it work (@see [Supported software](#supported-software)).

Make-up does stuff like:

<details>
  <summary>
    Initial project setup after git clone
  </summary>
  
  Make-up installs all required tools to get you started with development.
</details>

<details>
  <summary>
    Start developing process
  </summary>
  
  Make-up controls all necessary processes so that you can focus on programming.
</details>

<details>
  <summary>
    Deployment
  </summary>
  
  Make-up shows you where and how you can successfully deploy your project.
</details>

<details>
  <summary>
    Sync between environments
  </summary>
  
  Make-up synchronizes databases and files between different environments.
</details>

More features [here](#features).

---

**Table of contents**

<!-- TOC -->

- [Make-up](#make-up)
  - [Ad Make-up to your project](#ad-make-up-to-your-project)
  - [Features](#features)
  - [Customization](#customization)
    - [Add a new command](#add-a-new-command)
      - [Run a script from a command](#run-a-script-from-a-command)
      - [Access environmental variables](#access-environmental-variables)
    - [Overwrite an existing command](#overwrite-an-existing-command)
    - [Create a new bash script](#create-a-new-bash-script)
  - [Supported software](#supported-software)

<!-- /TOC -->

---


## Ad Make-up to your project

1. Add Make-up as a _submodule_ to your project:

   <!-- TODO: pfad anpassen -->

   ```bash
   cd my-project
   git submodule add git@lab.fork.de:fork/craft-docker-setup-scripts.git
   ```

1. Create a new file called "Makefile"

   ```bash
   cd my-project
   
   # create Makefile
   touch Makefile

   # Create reference to ./Makefile in ../Makefile (replace path-to)
   printf "include path-to/Makefile" >> Makefile
   ```

1. Create a **.env** file. This is where we will put **sensible information like passwords** etc. To avoid having this information in your project, make sure .env files are never added to your repository.

    ```bash
    cd my-project

    # create .env file
    touch .env

    # create .gitignore
    touch .gitignore

    # remove .env files from version control
    printf "\n.env" >> .gitignore
    ```

    If your project already contains a **.env** file you may continue using the existing one. Instead of creating a new file (example above), you will have to create a reference to that existing file.

    ```bash
    # create symbolic link to your .env file
    ln -s path-to/.env .env
    ```

## Features

To list all available commands, simply run

```bash
$ make help
```

## Customization

The scripts provided here contain general information to work for as many different project-setups as possible. All functions can therefore be modified, extended or overwritten. Überschreiben

### Add a new command

You may add your custom _Makefile_ methods to [./../Makefile](./../Makefile):

```Makefile
## this comment will appear in `$ make help` as a description of 'foo'
foo:
  @echo Bar
```

They will automatically show up in when you run `$ make help`.

#### Run a script from a command

You may run a bash script from a Makefile command like so:

```Makefile
@./path-to/foo.bash
```

If you want to run an existing script from Make-up, use the following:

```Makefile
@./$(HELPER_SCRIPTS)/foo.bash
```

#### Access environmental variables

From within your Makefile, you have direct access to each variable from [../site/.env](../site/.env).

So if this was in your _.env_ file:

    FOO="bar"

you could call the variable _FOO_

- in you bash script

  ```bash
  echo $FOO
  ```

- in your Makefile

  ```Makefile
  echo "$(FOO)"
  ```

### Overwrite an existing command

You may overwrite an existing command in [./../Makefile](./../Makefile), by reusing a method name, already appearing in `$ make help`. You may continue as if you would [add a new command](#add-a-new-command).

**Note:** _An overwridden command will produce a warning like this:_

    Makefile:x: warning: overwriding commands for target `foo'
    craft-docker-setup-scripts/Makefile:123: warning: ignoring old commands for target `foo'
    Bar

### Create a new bash script

Begin every bash script with the following lines:

```bash
#!/bin/bash

# load helper
my_dir="$(dirname "$0")"
source "$my_dir/helper.bash"
```

After having the [./helper.bash](./helper.bash) loaded, you may access gloabl variables like colors, text-transforms, etc.

**Note:** _Before you can execute a bash script, you have to modify its permissions:_

```bash
chmod +x my-script.bash
```

## Supported software

Make-up offers support for:

- Craft CMS 3
- Docker
- NPM
- Yarn

---

Brought to you by [4rk](https://fork.de) – 01/2020

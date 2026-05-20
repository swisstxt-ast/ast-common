# Repository Overview

This repository contains essential configuration files and installation scripts for team-wide consistency in Git usage.

## Usage

In order to use this configuration you will need to install it.

The installation scripts create symbolic links from the home directory to the configuration files in this repository. They back up any existing files before creating the links to ensure no data is lost.

Note that if you delete this repository then the Git configuration will stop working. If you move this repository you will have to run again the installation script.

## Dependencies
- [fzf](https://github.com/junegunn/fzf) - needed for `git cr`

## Installation

### Linux and WSL

```
./install.sh
```

### Windows (cmd.exe)

```
install.bat
```

## Configuration files

- **.gitconfig.user**: Your personal Git configuration file for your committer name/email, and any other custom changes that you don't plan to push to this common config repository.
- **.gitconfig**: Common Git configuration file for the team. Changes in this file should only be made if they are intended to be committed to this common config repository.
- **.gitignore**: Standard `.gitignore` file for the team.
- **.editorconfig**: [Universal](https://editorconfig.org/#pre-installed) editors configuration that specifies the type of line endings that should be used, indentation, etc.
- **.npmrc**: npm configuration.
- **.yarnrc.yml**: Yarn configuration.
- **bunfig.toml**: Bun configuration.
- **.config/uv/uv.toml**: uv configuration.
- **.config/pip/pip.conf**: pip configuration.

Note that since these files are symlinked to your home directory you can edit them here, push, and pull without needing to copy them or install them again afterward.

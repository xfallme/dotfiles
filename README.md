# My dotfiles repo, currently running on MacOS and Bazzite

This directory contains the dotfiles for my systems

## Requirements

Ensure you have the following installed on your system (requires [brew](https://brew.sh/))

### Git

```
brew install git
```

### Stow

```
brew install stow
```

## Installation

First, check out the dotfiles repo in your $HOME directory using git

```
$ git clone git@github.com/xfallme/dotfiles.git
$ cd dotfiles
```

then use the setup script to create symlinks

```
$ chmod +x setup.sh
$ ./setup.sh
```

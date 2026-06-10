#!/usr/bin/env bash
stow . --target=$HOME --ignore=.stowrc --ignore=common --ignore=macos --ignore=bazzite --ignore=DS_Store --ignore=setup.sh
stow common --target=$HOME/.config --ignore=DS_Store
if [[ "$OSTYPE" == "darwin"* ]]; then
    stow macos --target=$HOME/.config --ignore=DS_Store
    ln -s ~/.config/ssh/config ~/.ssh/config
fi

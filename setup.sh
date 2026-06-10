#!/usr/bin/env bash
stow common --target=$HOME/.config --ignore=DS_Store

if [[ "$OSTYPE" == "darwin"* ]]; then
    # tmux and zsh
    stow . --target=$HOME --ignore=.stowrc --ignore=common --ignore=macos --ignore=bazzite --ignore=DS_Store --ignore=setup.sh
    
    stow macos --target=$HOME/.config --ignore=DS_Store
    # check if link or file exists before creating it
    if [ ! -L ~/.ssh/config ] && [ ! -f ~/.ssh/config ]; then
        ln -s ~/.config/ssh/config ~/.ssh/config
    else
        echo "SSH config link or file already exists, skipping..."
    fi
fi

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    stow bazzite --target=$HOME/.config --ignore=DS_Store
fi

#!/usr/bin/env bash

read -p "switch brew mirror site, please enter switch to ustc(Y) or origin(N): " yn

function switch_to_ustc() {
    # brew
    cd "$(brew --repo)"
    git remote set-url origin https://mirrors.ustc.edu.cn/brew.git

    # brew-core
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-core.git

    # brew-cask
    cd "$(brew --repo)"/Library/Taps/homebrew/homebrew-cask
    git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
}

function switch_to_origin() {
    # brew
    cd "$(brew --repo)"
    git remote set-url origin https://github.com/Homebrew/brew.git

    # brew-core
    cd "$(brew --repo)/Library/Taps/homebrew/homebrew-core"
    git remote set-url origin https://github.com/Homebrew/homebrew-core

    # brew-cask
    cd "$(brew --repo)"/Library/Taps/homebrew/homebrew-cask
    git remote set-url origin https://github.com/Homebrew/homebrew-cask
}

case $yn in
    [Yy]* ) switch_to_ustc; echo "Switch to ustc done!";;
    [Nn]* ) switch_to_origin; echo "Switch to origin done!";;
    * ) echo "Nothing changed!"; exit;;
esac

#!/usr/bin/env bash

# back
cur_dir="$(pwd)"
cd temp

# clone
git clone https://github.com/powerline/fonts.git --depth=1

# install
cd fonts
./install.sh

# clean-up a bit
cd ..
rm -rf fonts

# restore
cd "$cur_dir"
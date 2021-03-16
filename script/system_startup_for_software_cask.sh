# only works on mac
[[ `uname -s` = "Darwin" ]] || exit

# install brew if not exists
if [ ! `command -v brew` ]; then
    /usr/bin/ruby -e `curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`
fi

brew_cask_list=`brew list --cask`
function update_cask_module {
    for name in $brew_cask_list; do
        if [ $name = "$1" ]; then
            echo "[INFO] - `date +%T` - already exists brew cask module [$1]."
            return
        fi
    done
    brew install --cask $1
}

update_cask_module hammerspoon
update_cask_module iterm2
update_cask_module google-chrome
update_cask_module evernote
update_cask_module fluor
update_cask_module visual-studio-code
update_cask_module open-in-code
update_cask_module karabiner-elements
update_cask_module IINA
update_cask_module sourcetree
update_cask_module tinypng4mac

# https://github.com/tonsky/FiraCode
brew tap homebrew/cask-fonts
update_cask_module font-fira-code
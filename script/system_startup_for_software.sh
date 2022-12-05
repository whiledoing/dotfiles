# only works on mac
[[ `uname -s` = "Darwin" ]] || exit

# install brew if not exists
if [ ! `command -v brew` ]; then
    /usr/bin/ruby -e `curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`
fi

# update brew only on not exists
brew_list=`brew list`
function update_module {
    for name in $brew_list; do
        if [ $name = "$1" ]; then
            echo "[INFO] - `date +%T` - already exists brew module [$1]."
            return
        fi
    done
    brew install $1
}

update_module git
update_module macvim
update_module tree
update_module telnet
update_module tmux
update_module autojump
update_module htop
update_module fzf
update_module thefuck
update_module mysql
update_module maven
update_module most
update_module wget
update_module node
update_module fd
update_module tldr
update_module node
update_module fpp
update_module urlview
update_module hub
update_module direnv
update_module npm
update_module git-delta
update_module asdf

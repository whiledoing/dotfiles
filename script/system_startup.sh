# start up system
#!/bin/sh

if [ `uname -s` = "Darwin" ]; then
# install brew if not exists
if ! type brew > /dev/null; then
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

brew_cask_list=`brew cask list`
function update_cask_module {
    for name in $brew_cask_list; do
        if [ $name = "$1" ]; then
            echo "[INFO] - `date +%T` - already exists brew cask module [$1]."
            return
        fi
    done
    brew cask install $1
}

update_module git
update_module macvim
update_module tree
update_module telnet
update_module ssh-copy-id
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

# update_cask_module visual-studio-code
update_cask_module hammerspoon
update_cask_module iterm2
update_cask_module google-chrome
update_cask_module evernote

# set vim cmd
alias vim="mvim -v"
fi

# update vim plugins
# vim +PlugInstall +qall

# install vim plugin manager
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "installing vim plug manager ..."
    curl -fsSLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# install oh-my-sh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "installing oh-my-sh ..."
    sh -c `curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh`
fi

# install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "installing tmux plugin manager ..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    tmux run-shell "$HOME/.tmux/plugins/tpm/bindings/update_plugins"
fi


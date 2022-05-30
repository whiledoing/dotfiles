#!/usr/bin/env bash
[[ `uname -s` = "Darwin" ]] || exit

# set vim cmd
alias vim="mvim -v"

# for visual studio vim plugin auto switch im
if [ ! `command -v im-select` ]; then
    curl -Ls https://raw.githubusercontent.com/daipeihust/im-select/master/install_mac.sh | sh
fi

# install vim plugin manager
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "installing vim plug manager ..."
    curl -fsSLo $HOME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    # update vim plugins
    vim +PlugInstall +qall
fi

# install oh-my-sh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "installing oh-my-sh ..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # plugin zsh-completions
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
    # plugin zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    # spaceship theme
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi

# install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "installing tmux plugin manager ..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    tmux run-shell "$HOME/.tmux/plugins/tpm/bindings/update_plugins"
fi

# install cnpm
if [ `command -v npm` ]; then
    npm i -g cnpm
fi

# install npm modules
if [ `command -v cnpm` ]; then
    cnpm i -g typescript
fi

# install xmake
[[ ! $(command -v xmake) ]] && bash <(curl -fsSL https://xmake.io/shget.text)
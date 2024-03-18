#!/bin/zsh

fpath=($DOTFILES/zsh/plugins $fpath)

#-- OPTIONS --#

unsetopt correct
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.


#-- THEME --#

ZSH_THEME=$ZSH_THEME
BASE16_SHELL="$HOME/.config/base16-shell/base16-material.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL


#-- SOURCE CONFIG FILES --#
#
source $DOTFILES/zsh/aliases
source $DOTFILES/zsh/functions
source $DOTFILES/zsh/prompt
source $DOTFILES/zsh/z
source $DOTFILES/zsh/completion


#-- VI MODE --#
set -o vi
bindkey -v
export KEYTIMEOUT=1

autoload -Uz cursor_mode; cursor_mode # change cursor in vi mode

export BAT_THEME="Catppuccin-macchiato"

#-- HISTORY --#

HISTSIZE=$HISTSIZE
HISTFILE=$HISTFILE
SAVEHIST=$SAVEHIST

setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.


#-- FZF --#

if [ $(command -v "fzf") ]; then
    # source /usr/local/opt/fzf/shell/completion.zsh
    # source /usr/local/opt/fzf/shell/key-bindings.zsh
    source $DOTFILES/zsh/scripts_fzf.zsh # fzf Scripts

    # Search with fzf and open selected file with Vim
    # bindkey -s '^v' 'nvim $(fzf);^M'
    bindkey -s '^f' 'search;^M'
fi

# determines search program for fzf
if type ag &> /dev/null; then
    export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'
fi

# prefer rg over ag
if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

#-- USER CONFIGURATION --#

chpwd() {
  ls -lrthG      # show contents of directory after cd-ing into it
}

# bindkey '^N'      insert-last-word       # allow completing of the remainder of a command
# bindkey '^I'      autosuggest-accept
bindkey '^E'   autosuggest-accept
bindkey -s '^o' 'nvim $(fzf-tmux)^M'
bindkey -s '^s' 'fst ^M'

# enable completion
autoload -U compinit
compinit

stty start undef     # disable flow control commands
stty stop undef      # (keeps C-s from freezing everything)

export LC_ALL=en_US.UTF-8

plugins=(
    asdf
    vi-mode
    zsh-navigation-tools
    zsh-autosuggestions
    zsh-syntax-highlighting
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=$ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)


export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# eval "$(rbenv init - zsh)"

source $ZSH/oh-my-zsh.sh

# nvm
unset npm_config_prefix # Add this line

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm() {
    unset -f nvm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    nvm "$@"
}

node() {
    unset -f node
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    node "$@"
}

npm() {
    unset -f npm
    export NVM_DIR=~/.nvm
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    npm "$@"
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. $HOME/.asdf/asdf.sh

export PATH=$PATH:/Users/sebastianbaroni/.spicetify
export PATH=$PATH:/usr/local/go/bin
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

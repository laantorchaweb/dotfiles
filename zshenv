#!/bin/zsh

export DOTFILES="$HOME/.dotfiles"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME='robbyrussell'

export EDITOR="nvim"
export VISUAL="nvim"

export HISTFILE="$HOME/.zsh_history"    # History filepath
export HISTSIZE=20000                   # Maximum events for internal history
export SAVEHIST=20000                   # Maximum events in history file

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#608680"

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/sebastianb/.cabal/bin:bin:/Users/sebastianb/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/git/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/.composer/vendor/bin:$PATH"
export PATH=$PATH:~/.cabal/bin
export PATH="$HOME/.bin:$PATH"

export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
export PATH="/usr/local/opt/luajit-openresty/bin:$PATH"
# export PATH="$(HOMEBREW_PREFIX)/opt/libpq/bin:$PATH"
export PATH=$PATH:$HOME/.spicetify
export PATH=$HOME/.config/nvcode/utils/bin:$PATH
. "$HOME/.cargo/env"

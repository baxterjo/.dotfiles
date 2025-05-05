#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


: "$LANG:=\"en_US.UTF-8\""
: "$LANGUAGE:=\"en\""
: "$LC_CTYPE:=\"en_US.UTF-8\""
: "$LC_ALL:=\"en_US.UTF-8\""

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="nvim"
export GPG_TTY=$(tty)
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export LANG LANGUAGE LC_CTYPE LC_ALL
export MANPAGER='nvim +Man!'
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rg"
export TERM="screen-256color"
export PATH=$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:$PATH

source $HOME/.cargo/env

# Common homebrew path initialization
command -v brew || export PATH="/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:$PATH"
command -v brew && eval "$(brew shellenv)"

# zsh-init
source "${HOMEBREW_PREFIX}/opt/zinit/zinit.zsh"

# plugins
zinit ice depth=1; zinit light zsh-users/zsh-syntax-highlighting
zinit ice depth=1; zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1; zinit light Aloxaf/fzf-tab

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# completions
autoload -Uz compinit && compinit

set completion-ignore-case on
set match-hidden-files off # do not autocomplete hidden files unless the pattern explicitly begins with a dot
zle_highlight=('paste:none')

plugins=(git)

HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTIGNORE="ls:ls *:cd:cd -:pwd;exit:date:* --help:* -h:* help:* -v:* --version:* version"
HISTDUP=erase
WORDCHARS="*?[]~&;!#$%^(){}<>" # allows to stop deletion on ./-_=

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -e
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# fix up/down
if [[ -n "${terminfo[kcuu1]}" ]]; then
 bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

if [[ -n "${terminfo[kcud1]}" ]]; then
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'



ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE='100' # limit suggestion to 100 chars
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

eval "$(zoxide init zsh)"
source <(fzf --zsh)

bindkey "^U" backward-kill-line # [Ctrl-u] deletes everything to the left of the cursor
bindkey '^[[3;3~' kill-word     # [Alt-del] delete word forwards
bindkey -s '\el' 'ls\n'         # [Esc-l] - run command: ls

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
bindkey "^[m" copy-prev-shell-word # [M-m] useful for renaming files to add suffix

# zsh syntax highlighting clears and restores aliases after .zshenv is loaded
# this keeps ls and ll aliased correctly
alias ls="eza --group-directories-first -G --color auto --icons -a -s type"
alias ll="eza --group-directories-first -l --color always --icons -a -s type"

# Rust
[ -f $HOME/.cargo/env ] && source $HOME/.cargo/env

# FZF

# Excluded dirs are set in ../fd/ignore
export FZF_DEFAULT_COMMAND="fd -d 1 --hidden --no-ignore-vcs --follow --color=never --strip-cwd-prefix"
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --prompt '  '
  --pointer ' '
  --marker '~ '
  --multi
  --bind 'ctrl-p:toggle-preview'
  --bind 'ctrl-e:become(nvim {})'
  --preview='bat {}'
  --preview-window 'hidden,border-left'
  --no-info
  --scrollbar=▏▕
  --color 'gutter:-1,hl+:#82aaff,hl:#82aaff,bg+:-1,pointer:#82aaff'"
export FZF_COMPLETION_OPTS=$FZF_DEFAULT_OPTS

# zoxide fzf opts
export _ZO_FZF_OPTS=$FZF_DEFAULT_OPTS

_fzf_compgen_path() {
	fd --hidden --follow --exclude ".git/" . "$1"
}

# Use fd to generate the list for directory completion
# Needs trigger **
_fzf_compgen_dir() {
	fd --type d --hidden --follow --exclude ".git/" . "$1"
}

################# ZSH widgets ####################

# search changed files in git repo
fzf-git-files-widget() {
  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    return 1
  fi

  local files=$(git diff --name-only)
  local lines=$(echo $files | wc -l)
  if [ $lines -eq 0 ]; then
    return 0
  fi

  if [ $lines -eq 1 ]; then
    RBUFFER=$files
  else
    local selected
    if selected=$(echo $files | fzf); then
      RBUFFER=$selected
    fi
  fi

  zle redisplay
  zle end-of-line
}

zle -N fzf-git-files-widget
bindkey -r '\eg'
bindkey '\eg' fzf-git-files-widget

# go back to fg
zsh-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N zsh-ctrl-z
bindkey '^z' zsh-ctrl-z

# edit current folder
zsh-ctrl-o () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="nvim ."
    zle accept-line
  fi
}
zle -N zsh-ctrl-o
bindkey -r '^o'
bindkey '^o' zsh-ctrl-o

# Add aliases to completion
compdef g='git'

echo "( .-.)"

source $ZSH/oh-my-zsh.sh
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

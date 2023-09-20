#!/bin/zsh

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ':vcs_info:*' enable git

precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst


zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:git:*' formats " %B%{$fg[blue]%}(%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})%{$reset_color%}"
zstyle ':vcs_info:git:*' formats " %B%{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})%{$reset_color%}"

local user="%{$fg[cyan]%}(%(!.%B%{$fg[red]%}.%{$fg[blue]%})%n%{$reset_color%}"
local separator="%{$fg[cyan]%}@%{$reset_color%}"
local host="%(!.%B%{$fg[red]%}.%{$fg[blue]%})%m%{$reset_color%}%{$fg[cyan]%})-%{$reset_color%}"
local current_dir="%{$fg[cyan]%}[%{$reset_color%}%{$fg[white]%}%~%{$reset_color%}%{$fg[cyan]%}]%{$reset_color%}"
#local user_symbol='%(!.#.$)'
local user_symbol='%{$fg[green]%}❯%{$reset_color%}'

PROMPT="${user}${separator}${host}${current_dir}\$vcs_info_msg_0_
${user_symbol} "

#!/usr/bin/env zsh

# Standarized $0 handling, following:
# https://github.com/zdharma/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
_DIRNAME="${0:h}"

DEPENDENCES_ZSH+=( zpm-zsh/colors )

if (( $+functions[zpm] )); then
  zpm zpm-zsh/colors,inline
fi

source "${_DIRNAME}/path.plugin.zsh"
source "${_DIRNAME}/hyperlink.plugin.zsh"
source "${_DIRNAME}/debug.plugin.zsh"

source "${_DIRNAME}/check-if.plugin.zsh"
source "${_DIRNAME}/is-recursive-exist.plugin.zsh"
source "${_DIRNAME}/is-true.plugin.zsh"
source "${_DIRNAME}/is-callable.plugin.zsh"
source "${_DIRNAME}/is-older.plugin.zsh"

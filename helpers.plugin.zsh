#!/usr/bin/env zsh

DEPENDENCES_ZSH+=( zpm-zsh/colors )

if (( $+function[zpm] )); then
  zpm zpm-zsh/colors
fi

source ${${(%):-%x}:a:h}/path.plugin.zsh
source ${${(%):-%x}:a:h}/hyperlink.plugin.zsh
source ${${(%):-%x}:a:h}/debug.plugin.zsh

source ${${(%):-%x}:a:h}/check-if.plugin.zsh
source ${${(%):-%x}:a:h}/is-recursive-exist.plugin.zsh
source ${${(%):-%x}:a:h}/is-true.plugin.zsh
source ${${(%):-%x}:a:h}/is-callable.plugin.zsh
source ${${(%):-%x}:a:h}/is-older.plugin.zsh

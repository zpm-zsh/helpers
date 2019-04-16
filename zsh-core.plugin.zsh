#!/usr/bin/env zsh

source ${${(%):-%x}:a:h}/completions.plugin.zsh
source ${${(%):-%x}:a:h}/correct.plugin.zsh
source ${${(%):-%x}:a:h}/history.plugin.zsh
source ${${(%):-%x}:a:h}/keyboard.plugin.zsh
source ${${(%):-%x}:a:h}/modules.plugin.zsh
source ${${(%):-%x}:a:h}/cd.plugin.zsh



is-recursive-exist(){
  local r_dir="$PWD"

  if [[ -d "$r_dir/$1" || -f "$r_dir/$1" ]]; then
    return 0
    echo "$r_dir/$1"
  fi
  while [[ "$r_dir" != "" ]]; do
    r_dir=$(dirname "$r_dir")
    if [[ "$r_dir" == '/' ]]; then
      r_dir=""
    fi
    if [[ -d "$r_dir/$1" || -f "$r_dir/$1" ]]; then
      return 0
    fi
  done

  return -1

}
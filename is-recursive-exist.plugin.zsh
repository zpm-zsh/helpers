#!/usr/bin/env zsh

is-recursive-exist(){
  local r_dir="$PWD"
  
  if [[ ! -w "$r_dir" ]]; then
    return -1
  fi

  if [[ -e "$r_dir/$1" ]]; then
    return 0
  fi

  while [[ "$r_dir" != "/" ]]; do
    r_dir="${r_dir:h}"
    if [[ ! -w "$r_dir" ]]; then
      return -1
    fi
   if [[ -e "$r_dir/$1" ]]; then
      return 0
    fi
  done
 
  return -1
  
}


#!/usr/bin/env zsh

is-recursive-exist(){
  local r_dir="$PWD"
  
  if [[ -d "$r_dir/$1" || -f "$r_dir/$1" ]]; then
    echo "$r_dir/$1"
	return 0
  fi
  while [[ "$r_dir" != "/" ]]; do
    r_dir="${r_dir:h}"
    if [[ -d "$r_dir/$1" || -f "$r_dir/$1" ]]; then
    echo -n "$r_dir/$1"  
	return 0
    fi
  done
 
  return -1
  
}


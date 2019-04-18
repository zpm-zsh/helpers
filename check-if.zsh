#!/usr/bin/env zsh

function check-if(){
  
  if [[ "$1" == 'linux' ]]; then
    [[ "$(uname)" == "Linux"  ]] && return 0 || return -1
  fi
  
  if [[ "$1" == 'termux' ]]; then
    [[ "$OSTYPE" == "linux-android"* ]] && return 0 || return -1
  fi

  if [[ "$1" == 'ssh' ]]; then
    [[ ! -z "$SSH_CONNECTION"  ]] && return 0 || return -1
  fi
  
  if [[ "$1" == 'tmux' ]]; then
    [[ ! -z "$TMUX"  ]] && return 0 || return -1
  fi
  
  return -1
  
}
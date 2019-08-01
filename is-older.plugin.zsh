#!/usr/bin/env zsh

function is-older() {
  [[ $2 -nt $1 ]]
  return $?
}

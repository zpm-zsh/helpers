#!/usr/bin/env zsh
# Standarized $0 handling, following:
# https://github.com/zdharma/Zsh-100-Commits-Club/blob/master/Zsh-Plugin-Standard.adoc
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

if (( $+functions[zpm] )); then
  zpm zpm-zsh/colors
fi

if [[ $PMSPEC != *f* ]] {
    fpath+=( "${0:h}/functions" )
}

autoload -Uz path fpath p 

appendpath () {
  if [[ ":${PATH}:" != *":${1}:"* ]]; then
    PATH="${PATH}:${1:A}"
  fi
}

prependpath () {
  if [[ ":${PATH}:" != *":${1}:"* ]]; then
    PATH="${1:A}:${PATH}"
  fi
}

appendfpath () {
  if [[ ":${FPATH}:" != *":${1}:"* ]]; then
    FPATH="${FPATH}:${1:A}"
  fi
}

prependfpath () {
  if [[ ":${FPATH}:" != *":${1}:"* ]]; then
    FPATH="${1:A}:${FPATH}"
  fi
}

hyperlink(){
  echo -e "\033]8;;${2}\a'${1}\033]8;;\a"
}

hyperlink-pr(){
  echo -e "%{\033]8;;${2}\a%}${1}%{\033]8;;\a%}"
}

hyperlink-file(){
  echo -e "\033]8;;file://${HOSTNAME:-$HOST}${2}\a${1}\033]8;;\a"
}

hyperlink-file-pr(){
  echo -e "%{\033]8;;file://${HOSTNAME:-$HOST}${2}\a%}${1}%{\033]8;;\a%}"
}

function debug() {
  local num
  if [[ -n "$DEBUG" &&  "${1}:" == "${DEBUG}:"*  ]]; then
    num=0
    
    for i in $(seq 1 ${#1}); do
      num=$(( $num + $(LC_CTYPE=C printf '%d' "'${1[$i]})") ))
    done
    color=$(( $num % 6 + 1 ))
    
    echo -n "[1;3${color}m$1 [0m"
    shift
    echo "$@"
  fi
}

function check-if(){
  if [[ "$1" == 'linux' ]]; then
    [[ "${OSTYPE}" == "linux-gnu" ]] && return 0 || return 1
  fi
  
  if [[ "$1" == 'bsd' ]]; then
    [[ "$(uname)" == *"BSD"* ]] && return 0 || return 1
  fi
  
  if [[ "$1" == 'macos' ]]; then
    [[ "$(uname)" == "Darwin"* ]] && return 0 || return 1
  fi
  
  if [[ "$1" == 'android' ]]; then
    [[ "${OSTYPE}" == "linux-android"* ]] && return 0 || return 1
  fi
  
  if [[ "$1" == 'termux' ]]; then
    [[ "${OSTYPE}" == "linux-android"* ]] && return 0 || return 1
  fi
  
  if [[ "$1" == 'ssh' ]]; then
    [[ ! -z "$SSH_CONNECTION" ]] && return 0 || return 1
  fi
  
  if [[ "$1" == 'vte' ]]; then
    [ "${VTE_VERSION:-0}" -ge 3405 ] && return 0 || return 1
  fi

  return 1
}
alias is=check-if

is-recursive-exist(){
  local r_dir="$PWD"
    
  if [[ -e "$r_dir/$1" ]]; then
    return 0
  fi
  
  while [[ "$r_dir" != "/" ]]; do
    r_dir="${r_dir:h}"
    if [[ -e "$r_dir/$1" ]]; then
      return 0
    fi
  done
  
  return -1
}

# Checks a boolean variable for "true".
# Case insensitive: "1", "y", "yes", "t", "true", "o", and "on".
function is-true() {
  [[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)|[Oo]([Nn]|)) ]]
}

# Checks if a name is a command, function, or alias.
function is-callable {
  (( $+commands[$1] || $+functions[$1] || $+aliases[$1] || $+builtins[$1] ))
}

function is-older() {
  [[ $2 -nt $1 ]]
  return $?
}

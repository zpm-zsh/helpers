#!/usr/bin/env zsh

if (( $+functions[zpm] )); then
  zpm zpm-zsh/colors
fi

appendpath () {
  if [[ ":${PATH}:" != *":${1}:"* ]]; then
    PATH="${PATH:+$PATH:}${1:A}"
  fi
}

prependpath () {
  if [[ ":${PATH}:" != *":${1}:"* ]]; then
    PATH="${1:A}${PATH:+$PATH:}"
  fi
}

appendfpath () {
  if [[ ":${FPATH}:" != *":${1}:"* ]]; then
    FPATH="${FPATH:+$FPATH:}${1:A}"
  fi
}

prependfpath () {
  if [[ ":${FPATH}:" != *":${1}:"* ]]; then
    FPATH="${1:A}${FPATH:+$FPATH:}"
  fi
}

path() {
  echo -n "${c[blue]}${c_bold}"
  echo $PATH | tr ":" "\n" |                                                    \
  awk "{                                                                        \
      sub(\"$HOME\",\"${c[cyan]}${c_bold}$HOME${c[blue]}${c_bold}\");           \
      sub(\"/usr\",\"${c[green]}${c_bold}/usr${c[blue]}${c_bold}\");            \
      sub(\"/bin\",\"${c[red]}${c_bold}/bin${c[blue]}${c_bold}\");              \
      sub(\"/\\\\.bin\",\"${c[red]}${c_bold}/.bin${c[blue]}${c_bold}\");        \
      sub(\"/sbin\",\"${c[red]}${c_bold}/sbin${c[blue]}${c_bold}\");            \
      sub(\"/games\",\"${c[blue]}${c_bold}/games${c[blue]}${c_bold}\");         \
      sub(\"/opt\",\"${c[cyan]}${c_bold}/opt${c[blue]}${c_bold}\");             \
      sub(\"/local\",\"${c[yellow]}${c_bold}/local${c[blue]}${c_bold}\");       \
      sub(\"/\\\\.local\",\"${c[yellow]}${c_bold}/.local${c[blue]}${c_bold}\"); \
      sub(\"/lib\",\"${c[magenta]}${c_bold}/lib${c[blue]}${c_bold}\");          \
      print }                                                                   \
  "
  echo -n "$c_reset"
}

fpath() {
  echo -n "${c[blue]}${c_bold}"
  echo $FPATH | tr ":" "\n" |                                                   \
  awk "{                                                                        \
      sub(\"$HOME\",\"${c[cyan]}${c_bold}$HOME${c[blue]}${c_bold}\");           \
      sub(\"/usr\",\"${c[green]}${c_bold}/usr${c[blue]}${c_bold}\");            \
      sub(\"/bin\",\"${c[red]}${c_bold}/bin${c[blue]}${c_bold}\");              \
      sub(\"/\\\\.bin\",\"${c[red]}${c_bold}/.bin${c[blue]}${c_bold}\");        \
      sub(\"/sbin\",\"${c[red]}${c_bold}/sbin${c[blue]}${c_bold}\");            \
      sub(\"/games\",\"${c[blue]}${c_bold}/games${c[blue]}${c_bold}\");         \
      sub(\"/opt\",\"${c[cyan]}${c_bold}/opt${c[blue]}${c_bold}\");             \
      sub(\"/local\",\"${c[yellow]}${c_bold}/local${c[blue]}${c_bold}\");       \
      sub(\"/\\\\.local\",\"${c[yellow]}${c_bold}/.local${c[blue]}${c_bold}\"); \
      sub(\"/lib\",\"${c[magenta]}${c_bold}/lib${c[blue]}${c_bold}\");          \
      print }                                                                   \
  "
  echo -n "$c_reset"
}

p() {
  local pa
  pa=$(pwd)
  pa=${pa//\//${c[red]}${c_bold}\/${c[blue]}${c_bold}}
  pa=${c[blue]}${c_bold}$pa
  echo $pa
}

hyperlink(){
  echo $'\033]8;;'"${2}"$'\a'${1}$'\033]8;;\a'
}

hyperlink-pr(){
  echo $'%{\033]8;;'"${2}"$'\a%}'${1}$'%{\033]8;;\a%}'
}

hyperlink-file(){
  echo $'\033]8;;file://'"${2}"$'\a'${1}$'\033]8;;\a'
}

hyperlink-file-pr(){
  echo $'%{\033]8;;file://'"${2}"$'\a%}'${1}$'%{\033]8;;\a%}'
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

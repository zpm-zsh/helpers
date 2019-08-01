#!/usr/bin/env zsh

appendpath () {
  case ":$PATH:" in
    *:"$1":*)
    ;;
    *)
    PATH="${PATH:+$PATH:}$1"
  esac
}

prependpath () {
  case ":$PATH:" in
    *:"$1":*)
    ;;
    *)
    PATH="$1${PATH:+$PATH:}"
  esac
}

appendfpath () {
  case ":$FPATH:" in
    *:"$1":*)
    ;;
    *)
    FPATH="${FPATH:+$FPATH:}$1"
  esac
}

prependfpath () {
  case ":$FPATH:" in
    *:"$1":*)
    ;;
    *)
    FPATH="$1${FPATH:+$FPATH:}"
  esac
}

path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",\"${c[green]}${c_bold}/usr${c_reset}\"); \
      sub(\"/bin\",\"${c[blue]}${c_bold}/bin${c_reset}\"); \
      sub(\"/games\",\"${c[red]}${c_bold}/games${c_reset}\"); \
      sub(\"/opt\",\"${c[cyan]}${c_bold}/opt${c_reset}\"); \
      sub(\"/sbin\",\"${c[magenta]}${c_bold}/sbin${c_reset}\"); \
      sub(\"/local\",\"${c[yellow]}${c_bold}/local${c_reset}\"); \
      print }"
}

p() {
    pa=$(pwd)
    pa=${pa//\//${c[red]}${c_bold}\/${c[blue]}${c_bold}}
    pa=${c[blue]}${c_bold}$pa
    echo $pa
}
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
  echo -n "${c[blue]}${c_bold}"
  echo $PATH | tr ":" "\n" | \
    awk "{ \
      sub(\"$HOME\",\"${c[cyan]}${c_bold}$HOME${c[blue]}${c_bold}\"); \
      sub(\"/usr\",\"${c[green]}${c_bold}/usr${c[blue]}${c_bold}\"); \
      sub(\"/bin\",\"${c[red]}${c_bold}/bin${c[blue]}${c_bold}\"); \
      sub(\"/\\\\.bin\",\"${c[red]}${c_bold}/.bin${c[blue]}${c_bold}\"); \
      sub(\"/games\",\"${c[blue]}${c_bold}/games${c[blue]}${c_bold}\"); \
      sub(\"/opt\",\"${c[cyan]}${c_bold}/opt${c[blue]}${c_bold}\"); \
      sub(\"/sbin\",\"${c[magenta]}${c_bold}/sbin${c[blue]}${c_bold}\"); \
      sub(\"/local\",\"${c[yellow]}${c_bold}/local${c[blue]}${c_bold}\"); \
      sub(\"/\\\\.local\",\"${c[yellow]}${c_bold}/.local${c[blue]}${c_bold}\"); \
      sub(\"/lib\",\"${c[magenta]}${c_bold}/lib${c[blue]}${c_bold}\"); \
      print }"
      echo -n "$c_reset"
}

p() {
    pa=$(pwd)
    pa=${pa//\//${c[red]}${c_bold}\/${c[blue]}${c_bold}}
    pa=${c[blue]}${c_bold}$pa
    echo $pa
}

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

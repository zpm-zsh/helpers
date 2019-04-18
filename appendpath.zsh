#!/usr/bin/env zsh

appendpath () {
  case ":$PATH:" in
    *:"$1":*)
    ;;
    *)
    PATH="${PATH:+$PATH:}$1"
  esac
}


#!/usr/bin/env zsh

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

#!/usr/bin/env zsh

# Standarized ZSH polyfills, following:
# https://z-shell.github.io/zsh-plugin-assessor/Zsh-Plugin-Standard
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

if [[ $PMSPEC != *f* ]] {
  fpath+=( "${0:h}/functions" )
}

autoload -Uz                       \
  path fpath p                     \
  appendpath     prependpath       \
  appendfpath    prependfpath      \
  appendmanpath  prependmanpath    \
  appendinfopath prependinfopath   \
  is-recursive-exist               \
  debug                            \
  is-callable is-true              \
  hyperlink hyperlink-pr           \
  hyperlink-file hyperlink-file-pr

typeset -Ag is

if [[ "${OSTYPE}" == "linux-gnu" ]]; then
  is[linux]=1
else
  is[linux]=0
fi

if [[ "${OSTYPE}" == *"freebsd"* ]]; then
  is[bsd]=1
else
  is[bsd]=0
fi

if [[ "${OSTYPE}" == "darwin"* ]]; then
  is[darwin]=1
  is[macos]=1
else
  is[darwin]=0
  is[macos]=0
fi

if [[ "${OSTYPE}" == "linux-android"* ]]; then
  is[android]=1
else
  is[android]=0
fi

if [[ -n "$SSH_CONNECTION" ]]; then
  is[ssh]=1
else
  is[ssh]=0
fi

if [[ "${VTE_VERSION:-0}" -ge 3405 ]]; then
  is[vte]=1
else
  is[vte]=0
fi

if [[ "$+commands[opkg]" == "1" ]]; then
  is[openwrt]=1
else
  is[openwrt]=0
fi

if [[ "${OSTYPE}" == "msys" ]]; then
  is[msys]=1
else
  is[msys]=0
fi

if [[ "${TERM_PROGRAM}" == "vscode" ]]; then
  is[vscode]=1
else
  is[vscode]=0
fi

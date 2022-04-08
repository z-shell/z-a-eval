# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
#
# Copyright (c) 2021 Nicholas Serrano
# License MIT

# Standardized $0 Handling
# https://z.digitalclouds.dev/community/zsh_plugin_standard#zero-handling
0="${ZERO:-${${0:#$ZSH_ARGZERO}:-${(%):-%N}}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Functions Directory
# https://z.digitalclouds.dev/community/zsh_plugin_standard#funtions-directory
if [[ $PMSPEC != *f* ]] {
    fpath+=( "${0:h}/functions" )
}

autoload →za-ev-atclone-handler →za-ev-atinit-handler →za-ev-recache

# An empty stub to fill the help handler fields
→za-ev-null-handler() { :; }

# Remove temporary variable
→za-ev-atload-handler() { [[ -n ${ICE[eval]} ]] && unset ZI_Z_A_EVAL_SOURCED; }

@zi-register-annex "z-a-eval" hook:atclone-50 \
  →za-ev-atclone-handler \
  →za-ev-null-handler "eval''" # also register new ices

@zi-register-annex "z-a-eval" hook:atpull-50 \
  →za-ev-atclone-handler \
  →za-ev-null-handler

@zi-register-annex "z-a-eval" hook:atload-50 \
  →za-ev-atload-handler \
  →za-ev-null-handler

@zi-register-annex "z-a-eval" hook:atinit-50 \
  →za-ev-atinit-handler \
  →za-ev-null-handler

@zi-register-annex "z-a-eval" subcommand:recache \
  →za-ev-recache \
  →za-ev-null-handler

(( Z_A_USECOMP )) || return;

# Annex provides a completion file with the prefix _zi
# Annex provies the 'shim' below which will run all available zi completions
# Lastly the shim is assigned as ZIs completion with a compdef call
autoload -Uz _zi_recache

_zi_shim(){
  unset -f $funcstack[1]
  eval "
    $funcstack[1](){
      ${(F)${(@ok)functions[(I)_zi*]/%/ \"\$@\"}//$funcstack[1] \"\$@\"}
    }
    eval $funcstack[1] \$@
  "
}
compdef _zi_shim zi

# vim: ft=zsh sw=2 ts=2 et

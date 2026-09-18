#!/usr/bin/env zsh
# -*- mode: zsh; sh-indentation: 2; indent-tabs-mode: nil; sh-basic-offset: 2; -*-
# vim: ft=zsh sw=2 ts=2 et
#
# The annex entry file must end with status 0 whether or not the optional
# completion shim is requested through Z_A_USECOMP (#3).

builtin emulate -R zsh
setopt pipe_fail

fail() {
  builtin print -u2 -r -- "not ok - $1"
  exit 1
}

typeset plugin_file="${ZI_TEST_CHECKOUT:-${0:A:h:h}}/z-a-eval.plugin.zsh"
[[ -r $plugin_file ]] || fail "plugin file not found: $plugin_file"

# Source the entry file in a clean process with the Zi registration API and
# the completion system stubbed, and report the source status plus whether the
# completion shim was defined.
probe() {  # probe <label> <Z_A_USECOMP value or "unset"> <expected shim 0|1>
  local label=$1 value=$2 expect_shim=$3 out
  local -a env_prefix=( env -u Z_A_USECOMP )
  [[ $value == unset ]] || env_prefix=( env "Z_A_USECOMP=$value" )
  out="$( "${env_prefix[@]}" zsh -f -c '
    @zi-register-annex() { :; }
    compdef() { :; }
    builtin source "$1"
    integer rc=$?
    builtin print -r -- "status=$rc shim=$(( $+functions[_zi_shim] ))"
  ' _ "$plugin_file" 2>&1 )" || fail "$label: probe shell failed: $out"
  [[ $out == "status=0 shim=$expect_shim" ]] || fail "$label: expected 'status=0 shim=$expect_shim', got '$out'"
}

probe "Z_A_USECOMP unset" unset 0
probe "Z_A_USECOMP=0" 0 0
probe "Z_A_USECOMP=1" 1 1

builtin print -r -- "ok - the entry file returns status 0 with and without the completion shim"

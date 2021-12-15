# ZI Annex `EVAL`

### Author: [NICHOLAS85](https://gihub.com/NICHOLAS85)

### **Wiki:** [z-a-eval](https://github.com/z-shell/zi/wiki/z-a-eval)

## Introduction

> This repository compatible with [ZI](https://github.com/z-shell/zi).

An Annex (i.e. an extension) that provides additional functionality, which allows to:

1. Cache the output of arbitrarily slow initialization command to speed up shell startup time.

## Installation

Simply load like a regular plugin, i.e.:

```zsh
zi light z-shell/z-a-eval
```

After executing this command you can then use the new ice-mods provided by
the annex.

## How it works

The output of a slow initialization command is redirected to a file located within the plugin/snippets directory and sourced while loading. The next time the plugin/snippet is loaded, this file will be sourced skipping the need to run the initialization command.

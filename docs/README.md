<table style="align:center;width:100%;height:auto"><tr><td align="center">
  <h1 align="center">
    <a href="https://github.com/z-shell/zi">
      <img style="align:center;width:80px;height:auto" src="https://github.com/z-shell/zi/raw/main/docs/images/logo.svg" />
    </a>❮ ZI ❯ Annex - Eval
  </h1>
<h2>Allows to cache the output of arbitrarily slow initialization command to speed up shell startup time.
</h2>
    <img align="center" src="images/recache.png" alt="eval preview" />
  </td>
</tr>
</table>

Annex provides a completion file with the prefix _zi, the 'shim' below which will run all available zi completions and the shim is assigned as ZIs completion with a compdef call

Synopsis:

```shell
zi recache <plugin/snippet>
```

## 💡 Wiki

- [annexes](https://z.digitalclouds.dev/docs/ecosystem/annexes)

## Installation

Simply load like a regular plugin:

```shell
zi light z-shell/z-a-eval
```

After executing this command you can then use the new ice-mods provided by
the annex.

## How it works

The output of a slow initialization command is redirected to a file located within the plugin/snippets directory and sourced while loading. The next time the plugin/snippet is loaded, this file will be sourced skipping the need to run the initialization command.

---

> This repository compatible with [ZI](https://github.com/z-shell/zi).

## Credits

Author: [NICHOLAS85](https://gihub.com/NICHOLAS85)

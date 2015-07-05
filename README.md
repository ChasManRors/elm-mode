# elm-mode

Elm mode for EMACS.

## Features

1. Syntax highlighting.
1. Intelligent indentation.
1. Integration with [elm-make](https://github.com/elm-lang/elm-make).
1. Integration with [elm-repl](https://github.com/elm-lang/elm-repl).
1. Integration with [elm-reactor](https://github.com/elm-lang/elm-reactor).

## Installation

### MELPA

If your Emacs has `package.el` (which is automatically the case
for Emacs >= 24), you can install `elm-mode` from the package in
[MELPA](http://melpa.milkbox.net/).

### From source

Add this repo to your load-path and `(require elm-mode)`. Ensure that
the following dependencies are available:

* [f](https://github.com/rejeep/f.el)
* [let-alist](https://github.com/Malabarba/let-alist)
* [s](https://github.com/magnars/s.el)

This package assumes you are runing Emacs 24 or later.

## Bindings

The following bindings are available in `elm-mode`:

<dl>
  <dt><code>C-c C-l</code></dt>
  <dd>Load the current file in a REPL.</dd>

  <dt><code>C-c C-p</code></dt>
  <dd>Push the current region to a REPL.</dd>

  <dt><code>C-c C-e</code></dt>
  <dd>
    Push the current declaration to a REPL (requires <code>haskell-mode</code>
    to be available -- highly experimental).
  </dd>

  <dt><code>C-c C-c</code></dt>
  <dd>Compile the current buffer.</dd>

  <dt><code>C-c M-c</code></dt>
  <dd>Compile the <code>Main.elm</code> file.</dd>

  <dt><code>C-c C-n</code></dt>
  <dd>Preview the current buffer in a browser (requires <code>elm-reactor</code>).</dd>

  <dt><code>C-c C-m</code></dt>
  <dd>Preview the <code>Main.elm</code> file in a browser (requires <code>elm-reactor</code>).</dd>
</dl>

+++
date = '2025-10-27'
draft = false
title = "Using the New PyREPL in VSCode"
tags = ["Python", "REPL", "VSCode", "Issue"]
+++

{{< figure src="VSCode_PyREPL_Example.webp" alt="PyREPL example in VSCode showing various coloured examples" caption="PyREPL in VSCode is Possible" >}}

## The PyREPL

I use the REPL all the time and I'm enjoying the new PyREPL.  
If you haven't yet moved to Python 3.14, you should - PyREPL is another compelling reason to update.

The new PyREPL has been available since Python 3.13, and replaces the original C-based REPL with a Python-based implementation (PyREPL). You can read about the PyREPL in ['PEP 762 – REPL-acing the default REPL'](https://peps.python.org/pep-0762/).

Key benefits of the new PyREPL:

- Coloured output for improved readability
- New built-in commands (exit, quit, copyright, help, clear)
- Improved paste handling for multi-line code
- Block-level history and a persistent history file (`.python_history`)
- Better Windows/PowerShell support
- Inline help and history convenience keys (F1/F2 mappings may vary by terminal)

## Using the PyREPL in VSCode

I've had trouble with the terminal in VSCode in the past (see [this blog post](https://jbeattie5768.github.io/posts/2025-08-29-vscode-terminal-does-not-match-the-windows-path-environment/)), and by default **VSCode currently disables the PyREPL** ([VSCode-Python Issue #25240](https://github.com/microsoft/vscode-python/issues/25240)) - this is the case in the September 2025 (version _1.105.1_) release:

{{< figure src="image.png" alt="VSCode terminal showing the default (C-based) Python REPL" caption="VSCode showing the default (C-based) Python REPL — no PyREPL features such as coloured output or easy exit." >}}

Not ideal.

This also appears to be the case for the VSCode Insiders version (I observed it in the _1.106.0-insider_ version).  
I expect this to be a temporary thing for VSCode, and that the VSCode team is working on changing it.

VSCode sets the [`PYTHON_BASIC_REPL`](https://docs.python.org/3/using/cmdline.html#envvar-PYTHON_BASIC_REPL) environment variable within its environment, which forces the basic REPL and prevents PyREPL from loading.

You **can** change this default behaviour in your VSCode **user** settings (`settings.json`) by adding:

```json
{
  // Disable Python extension shell integration so the system can load PyREPL
  "python.terminal.shellIntegration.enabled": false
}
```

You'll need to _kill_ the terminal for it to take effect:

{{< figure src="image-1.png" alt="PyREPL in VSCode showing coloured prompts and easy exit" caption="PyREPL in VSCode: coloured output, and easy exit." >}}

A thing of beauty!

>If you still see the old REPL after changing the user settings, restart VSCode.
{.note}

There have been reports of cursor indentation issues (see [CPython Issue #126131](https://github.com/python/cpython/issues/126131)) when using PyREPL in VSCode, but I've not noticed any major issues **yet**.

---

## Essential Keyboard Shortcuts

There are a number of keyboard bindings (keyboard shortcuts) available for the new PyRepl. These bindings are defined in the default CPython keymap in [Lib/_pyrepl/reader.py](https://github.com/python/cpython/blob/3.14/Lib/_pyrepl/reader.py) and extended for history in [Lib/_pyrepl/historical_reader.py](https://github.com/python/cpython/blob/3.14/Lib/_pyrepl/historical_reader.py).

The key ones _[pun absolutely intended]_ I use are:

| Key Combination | Action |
| --- | --- |
| Ctrl+c | interrupt |
| Ctrl+g | cancel |
| Ctrl+k | kill-line |
| Ctrl+l | clear-screen |
| Ctrl+n | next-history |
| Ctrl+p | previous-history |
| Ctrl+r | reverse-history-isearch |
| F1 | help |
| F2 | show-history |

>Use Ctrl+n/Ctrl+p to skip scrolling through history code blocks.
{.note}

I also use standard key combinations, such as the _Home/End keys_, _Ctrl + <-/->_, _Ctrl + Shift <-/->_, and so on.

Extended bindings I tend not to use frequently enough to memorise:

| Key Combination | Action |
| --- | --- |
| Ctrl+a | beginning-of-line |
| Ctrl+b | left |
| Ctrl+d | delete |
| Ctrl+e | end-of-line |
| Ctrl+f | right |
| Ctrl+h | backspace |
| Ctrl+j | accept (enter) |
| Ctrl+m | accept |
| Ctrl+t | transpose-characters |
| Ctrl+u | unix-line-discard |
| Ctrl+w | unix-word-rubout |
| Ctrl+y | yank |
| Meta+b | backward-word |
| Meta+c | capitalize-word |
| Meta+d | kill-word |
| Meta+f | forward-word |
| Meta+l | downcase-word |
| Meta+t | transpose-words |
| Meta+u | upcase-word |
| Meta+y | yank-pop |
| Meta+- | digit-arg |
| Meta+0..9 | digit-arg |
| Ctrl+o | operate-and-get-next |
| Ctrl+s | forward-history-isearch |
| Meta+r | restore-history |
| Page Down | history-search-forward |
| Page Up | history-search-backward |
| F3 | paste-mode |

>On Windows and Linux, use Alt for Meta.  
>On Mac, use Option (⌥) for Meta (unless your terminal remaps it).
{.note}

---

## References

- <https://github.com/pypy/pypy/tree/d102094b863ce49b7af030dcb0cecaac515d97c6/lib_pypy/pyrepl>
- <https://peps.python.org/pep-0762>
- <https://github.com/microsoft/vscode-python/issues/25164>  
- <https://github.com/microsoft/vscode-python/issues/25240>
- <https://github.com/microsoft/vscode-python/pull/25216>
- <https://github.com/microsoft/vscode-python/pull/25281>  
- <https://github.com/python/cpython/issues/126172>  
- <https://github.com/python/cpython/issues/126131>
- <https://code.visualstudio.com/docs/terminal/shell-integration>

---

### Edits to this Post

- 30 Oct 2025: Added banner image to post.
- 05 Jan 2026: Added keyboard shortcuts section

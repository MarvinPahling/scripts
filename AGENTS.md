# Agent instructions

## Purpose

This repository contains standalone scripts for a personal workflow. Keep each script focused on one task. Combine existing command-line tools instead of adding a framework.

## Preferred tools

- Use `fzf` as the picker for new interactive scripts. The existing tmux scripts use `sk`.
- Use `rg` to search text. Use `fd` to find files and directories.
- Use `sioyek` to open PDFs. Use `nvim` for editor tasks.
- Keep task-specific tools when needed. For example, `present` uses `pympress` for presentations.

## Script layout

- Save new command scripts at the repository root (`~/.config/scripts`) without a filename extension.
- Keep extensions on supporting files, such as the Pandoc Lua filter and template.
- Make standalone scripts executable with `chmod +x <script>`.
- Start new Bash scripts with `#!/usr/bin/env bash`. Existing scripts can use a different shebang, such as `#!/bin/bash` in `pdfs`.
- Start Python scripts with `#!/usr/bin/env -S uv run --script`. Declare the Python version and dependencies in inline `# /// script` metadata.
- Keep `hist` as a zsh function that users can source. It has no shebang.
- Resolve paths to sibling scripts and resources from the script's directory, not the current directory.

## Behavior

- For an interactive choice, pipe candidates to `fzf`, as `pdfs` does with `fd`. Act only when the user selects an item.
- Exit without side effects when the user cancels or makes no selection. Handle cancellation even with `set -e` or `pipefail`.
- Quote paths and variable expansions so paths with spaces work.
- Check inputs and required commands. Send errors to stderr. Return a nonzero status on errors.
- Preserve a script's existing arguments and output unless the task requires a change.
- Preserve platform-specific behavior, such as the macOS and Linux branches in `theme`.

## Checks

- Check shell syntax with `bash -n <script>` or `zsh -n <script>`, as appropriate.
- For Python, use `compile()` to check syntax. This check must not run the script.
- Test picker cancellation when relevant. Test paths with spaces when relevant.
- Use temporary files or mock commands for checks that would change user data or settings.

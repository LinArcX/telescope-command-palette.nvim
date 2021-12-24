# :telescope: telescope-command-palette.nvim

`telescope-command-palette.nvim` is a neovim plugin written entirely in lua that will help you to access your custom commands/function/key-bindings.

# Demo

![Demo](./command_palette.gif)


# Installation

### Vim-Plug

```viml
Plug "LinArcX/telescope-command-palette.nvim"
```

### Packer

```lua
use { "LinArcX/telescope-command-palette.nvim" }
```

# Setup and Configuration

First load the extension:
```lua
require('telescope').load_extension('command_palette')
```

And then declare the `CpMenu` items like this:

```lua
CpMenu = {
  {"Help",
    { "tips", ":help tips" },
    { "cheatsheet", ":help index" },
    { "tutorial", ":help tutor" },
    { "summary", ":help summary" },
    { "quick reference", ":help quickref" },
    { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
  {"Vim",
    { "current working directory", ":pwd" },
    { "reload vimrc", ":source $MYVIMRC"},
  }
}
```

The idea is that you decleare some **categories**("Help", "Vim", etc..) and inside each category, you define your commands.
Each command has three parts:
- description
- command
- insert/normal mode (indicates that whether you want to be in insert mode after run the command or not. **1** means: insert mode. everything else is normal mode)

## Per project configurations

If you're working on different projects and want to have special key_bindings per project, you can create a `.nvimrc` in root of your project and append items to `CpMenu` like this:

```lua

table.insert(CpMenu,
  {"Dap",
    { "pause", ":lua require'dap'.pause()" },
    { "step into", ":lua require'dap'.step_into()" },
    { "step back", ":lua require'dap'.step_back()" },
    { "step over", ":lua require'dap'.step_over()" },
    { "step out", ":lua require'dap'.step_out()" },
    { "frames", ":lua require'telescope'.extensions.dap.frames{}" },
    { "current scopes", ":lua ViewCurrentScopes(); vim.cmd(\"wincmd w|vertical resize 40\")" },
    { "current scopes floating window", ":lua ViewCurrentScopesFloatingWindow()" },
    { "current value floating window", ":lua ViewCurrentValueFloatingWindow()" },
    { "commands", ":lua require'telescope'.extensions.dap.commands{}" },
    { "configurations", ":lua require'telescope'.extensions.dap.configurations{}" },
    { "repl", ":lua require'dap'.repl.open(); vim.cmd(\"wincmd w|resize 12\")" },
    { "close", ":lua require'dap'.close(); require'dap'.repl.close()" },
    { "run to cursor", ":lua require'dap'.run_to_cursor()" },
    { "continue", ":lua require'dap'.continue()" },
    { "clear breakpoints", ":lua require('dap.breakpoints').clear()" },
    { "brakpoints", ":lua require'telescope'.extensions.dap.list_breakpoints{}" },
    { "toggle breakpoint", ":lua require'dap'.toggle_breakpoint()" },
  })

```

## Default mappings (insert mode):

| Key   | Description                                                   |
| ---   | ------------------------------------------------------------- |
| `c-b` | go back to categories                                         |

## Default mappings (normal mode):

| Key   | Description                                                   |
| ---   | ------------------------------------------------------------- |
| `c-b` | go back to categories                                         |

# Usage
`:Telescope command_palette`.

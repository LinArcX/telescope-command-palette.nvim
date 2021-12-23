# telescope-command-palettete.nvim

`telescope-command-palettete.nvim` is a neovim plugin written entirely in lua that will help you to access your custom commands/function/key-bindings.

# Demo

![Demo](./media/fb-demo.gif)

# Installation

### Vim-Plug

```viml
Plug "LinArcX/telescope-command-palettete.nvim"
```

### Packer

```lua
use { "LinArcX/telescope-command-palettete.nvim" }
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
        { "search help", ":lua require('telescope.builtin').help_tags()" },
    },
    {"Vim",
        { "current working directory", ":pwd" },
        { "reload vimrc", ":source $MYVIMRC"},
    }
}
```

## Per project configurations

If you're working on different projects and want to have special keys per project, you can create .nvimrc in root of your project and append items to `CpMenu` like this:

```lua
table.insert(CpMenu,
    {"Dap",
        { "toggle breakpoint", "lua require'dap'.toggle_breakpoint()" },
        { "brakpoints", "lua require'telescope'.extensions.dap.list_breakpoints{}" },
        { "clear breakpoints", "lua require('dap.breakpoints').clear()" },
        { "continue", "lua require'dap'.continue()" },
        { "run to cursor", "lua require'dap'.run_to_cursor()" },
        { "pause", "lua require'dap'.pause()" },
        { "close", "lua require'dap'.close(); require'dap'.repl.close()" },
        { "up", "lua require'dap'.up()" },
        { "down", "lua require'dap'.down()" },
        { "step into", "lua require'dap'.step_into()" },
        { "step back", "lua require'dap'.step_back()" },
        { "step over", "lua require'dap'.step_over()" },
        { "step out", "lua require'dap'.step_out()" },
    })
```

# Usage
Just run: `:Telescope command_palette`.

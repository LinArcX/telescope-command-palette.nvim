# telescope-command-palettete.nvim

`telescope-command-palettete.nvim` is a neovim plugin written entirely in lua progamming language that will help you to run your custom commands/function easily.

# Demo

![Demo](./media/fb-demo.gif)

# Installation

### packer

```lua
use { "LinArcX/telescope-command-palettete.nvim" }
```

### Vim-Plug

```viml
Plug "LinArcX/telescope-command-palettete.nvim"
```

# Setup and Configuration

```lua
require('telescope').load_extension('command_palette')

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

table.insert(CpMenu,
    {"Dap",
        { "toggle breakpoint", "lua require'dap'.toggle_breakpoint()" },
    })
```

# Usage
Just run: `:Telescope command_palette`

<!-- # Contributing -->

<!-- Contributions are very welcome! -->

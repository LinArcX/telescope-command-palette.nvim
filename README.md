# ARCHIVED
I won't develop this plugin anymore since I found which-key far better than mine:
https://github.com/folke/which-key.nvim


# :telescope: telescope-command-palette.nvim

`telescope-command-palette.nvim` is a neovim plugin written entirely in lua that will help you to access your custom commands/function/key-bindings.

# Demo

![Demo](https://user-images.githubusercontent.com/10884422/148601223-5ade5806-9935-4ff7-888c-d00b41178a96.gif)


# Installation

### Vim-Plug

```viml
Plug "nvim-telescope/telescope.nvim"
Plug "LinArcX/telescope-command-palette.nvim"
```

### Packer

```lua
use { "nvim-telescope/telescope.nvim" }
use { "LinArcX/telescope-command-palette.nvim" }
```

# Setup and Configuration

First set up your commands in your Telescope config:

```lua
require('telescope').setup({
  extensions = {
    command_palette = {
      {"File",
        { "entire selection (C-a)", ':call feedkeys("GVgg")' },
        { "save current file (C-s)", ':w' },
        { "save all files (C-A-s)", ':wa' },
        { "quit (C-q)", ':qa' },
        { "file browser (C-i)", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
        { "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1 },
        { "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
        { "files (C-f)",     ":lua require('telescope.builtin').find_files()", 1 },
      },
      {"Help",
        { "tips", ":help tips" },
        { "cheatsheet", ":help index" },
        { "tutorial", ":help tutor" },
        { "summary", ":help summary" },
        { "quick reference", ":help quickref" },
        { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
      },
      {"Vim",
        { "reload vimrc", ":source $MYVIMRC" },
        { 'check health', ":checkhealth" },
        { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
        { "commands", ":lua require('telescope.builtin').commands()" },
        { "command history", ":lua require('telescope.builtin').command_history()" },
        { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
        { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
        { "vim options", ":lua require('telescope.builtin').vim_options()" },
        { "keymaps", ":lua require('telescope.builtin').keymaps()" },
        { "buffers", ":Telescope buffers" },
        { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
        { "paste mode", ':set paste!' },
        { 'cursor line', ':set cursorline!' },
        { 'cursor column', ':set cursorcolumn!' },
        { "spell checker", ':set spell!' },
        { "relative number", ':set relativenumber!' },
        { "search highlighting (F12)", ':set hlsearch!' },
      }
    }
  }
})
```

And then load the extension:

```lua
require('telescope').load_extension('command_palette')
```

The idea is that you declare some **categories**("Help", "Vim", etc..) and inside each category, you define your commands.
Each command has three parts:
- __description__(mandatory)
- __command__(mandatory)
- __insert_mode/normal_mode flag__(optional) (indicates that whether you want to be in insert_mode after run the command or not. **1** means: insert mode. **everything else** is normal mode)

Tip: `CpMenu` is just a simple [table](https://www.lua.org/pil/2.5.html).

## Per project configurations

If you're working on different projects and want to have special key_bindings per project, you can create a `.nvimrc` file in root of your project and append items to `CpMenu` like this:

```lua

table.insert(require('command_palette').CpMenu,
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


# Contribution
If you have any idea to improve this project, please create a pull-request for it. To make changes consistent, i have some rules:
1. Before submit your work, please format it with [StyLua](https://github.com/JohnnyMorganz/StyLua).
    1. Just go to root of the project and call: `stylua .`

2. There should be a one-to-one relation between features and pull requests. Please create separate pull-requests for each feature.
3. Please use [snake_case](https://en.wikipedia.org/wiki/Snake_case) for function names and local variables
4. If your PR have more than one commit, please squash them into one.
5. Use meaningful name for variables and functions. Don't use abbreviations as far as you can.


# Roadmap :blue_car:
- :heavy_check_mark: use __modules__ and __setup__ function. (Thanks to: [mrjones2014](https://github.com/mrjones2014))
- [ ] let users chose the __separator__ icon.
- [ ] make categories per os/distro.
- [ ] allow users to define keybindings for items in categories/commands.
- [ ] remember the selected item in come back to categories.
- [ ] show frequently commands based on frecency algorithm.
- [ ] add options to make telescope-command-palette.nvim more like vscode command-palatte. (like: @, ...)

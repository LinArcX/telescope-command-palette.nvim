local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local entry_display = require('telescope.pickers.entry_display')

CpMenu = {}

local function tableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local function listOfCategories()
    Results = {}
    for i = tableLength(CpMenu),1,-1 do
        Results[i] = CpMenu[i][1]
    end
    return Results
end

local function listOfCommands(index)
    local results = {}
    local j = 1
    for i = tableLength(CpMenu[index]),2,-1 do
        results[j] = CpMenu[index][i]
        j = j + 1
    end
    return results
end

-- picker: commands
local function commands(opts, table)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "commands",
    finder = finders.new_table {
        results = table,
        entry_maker = function(entry)
            local cols = vim.o.columns
            local width = conf.width
                or conf.layout_config.width
                or conf.layout_config[conf.layout_strategy].width
                or cols
            local tel_win_width
            -- width = 80 -> column width, width = 0.7 -> ratio
            if width > 1 then
                tel_win_width = width
            else
                tel_win_width = math.floor(cols * width)
            end
            local cheatcode_width = math.floor(cols * 0.05)
            local section_width = 28

            -- NOTE: the width calculating logic is not exact, but approx enough
            local displayer = entry_display.create {
                separator = " ▏",
                items = {
                    { width = section_width }, -- section
                    {
                        width = tel_win_width - cheatcode_width
                            - section_width,
                    }, -- description
                    { remaining = true }, -- cheatcode
                },
            }

            local function make_display(ent)
                return displayer {
                    { entry[1] },
                    { entry[2] },
                }
            end

            return {
                value = entry,
                display =  make_display,
                ordinal = string.format('%s %s', entry[1], entry[2]
                ),
            }
        end,

    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.api.nvim_exec(selection.value[2], true)
      end)
      return true
    end,
  }):find()
end

-- picker: categories
local function categories(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "categories",
    finder = finders.new_table {
        results = listOfCategories(),
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        -- Due to issue: 1599, we shouldn't close prompt_bufnr here.
        -- actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        commands(opts, listOfCommands(selection.index))
      end)
      return true
    end,
  }):find()
end

return require('telescope').register_extension {
    exports = {
        -- Default when to argument is given, i.e. :Telescope command_palette
        command_palette = categories,
    }
}

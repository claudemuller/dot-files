-- Define the function
function _G.select_make_target()
  local telescope = require 'telescope'
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  local function get_make_targets()
    local targets = {}
    local makefile = io.popen "make -qp | awk -F: '/^[a-zA-Z0-9][^$#\\/\\t=]*:([^=]|$)/ {print $1}' | sort | uniq"
    if makefile then
      for line in makefile:lines() do
        table.insert(targets, line)
      end
      makefile:close()
    end
    return targets
  end

  local targets = get_make_targets()
  require('telescope.pickers')
    .new({}, {
      prompt_title = 'Make Targets',
      finder = require('telescope.finders').new_table {
        results = targets,
      },
      sorter = require('telescope.config').values.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            vim.cmd('!make ' .. selection.value)
          end
        end)
        return true
      end,
    })
    :find()
end

-- Define the keymap after the function
vim.api.nvim_set_keymap('n', '<C-F5>', ':lua select_make_target()<CR>', { noremap = true, silent = true })

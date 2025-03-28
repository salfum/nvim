local file_ignore_patterns = {
  "node_modules",
  "deps",
}

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local transform_mod = require("telescope.actions.mt").transform_mod

local function multiopen(prompt_bufnr, method)
  local cmd_map = {
    vertical = "vsplit",
    horizontal = "split",
    tab = "tabe",
    default = "edit",
  }
  local picker = action_state.get_current_picker(prompt_bufnr)
  local multi_selection = picker:get_multi_selection()

  if #multi_selection > 1 then
    require("telescope.pickers").on_close_prompt(prompt_bufnr)
    pcall(vim.api.nvim_set_current_win, picker.original_win_id)

    for i, entry in ipairs(multi_selection) do
      -- opinionated use-case
      local cmd = i == 1 and "edit" or cmd_map[method]
      vim.cmd(string.format("%s %s", cmd, entry.value))
    end
  else
    actions["select_" .. method](prompt_bufnr)
  end
end

local custom_actions = transform_mod {
  multi_selection_open_vertical = function(prompt_bufnr) multiopen(prompt_bufnr, "vertical") end,
  multi_selection_open_horizontal = function(prompt_bufnr) multiopen(prompt_bufnr, "horizontal") end,
  multi_selection_open_tab = function(prompt_bufnr) multiopen(prompt_bufnr, "tab") end,
  multi_selection_open = function(prompt_bufnr) multiopen(prompt_bufnr, "default") end,
}

local function stopinsert(callback)
  return function(prompt_bufnr)
    vim.cmd [[stopinsert]]
    vim.schedule(function() callback(prompt_bufnr) end)
  end
end

local custom_mappings = {
  i = {
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,

    ["<C-v>"] = stopinsert(custom_actions.multi_selection_open_vertical),
    ["<C-s>"] = stopinsert(custom_actions.multi_selection_open_horizontal),
    ["<C-t>"] = stopinsert(custom_actions.multi_selection_open_tab),
    -- ["<CR>"] = stopinsert(custom_actions.multi_selection_open),
    ["<CR>"] = function(pb)
      local picker = action_state.get_current_picker(pb)
      local multi = picker:get_multi_selection()
      actions.select_default(pb) -- the normal enter behaviour
      for _, j in pairs(multi) do
        if j.path ~= nil then -- is it a file -> open it as well:
          vim.cmd(string.format("%s %s", "edit", j.path))
        end
      end
    end,
    ["<C-S-d>"] = require("telescope.actions").delete_buffer,
  },
  n = {
    ["<C-v>"] = custom_actions.multi_selection_open_vertical,
    ["<C-s>"] = custom_actions.multi_selection_open_horizontal,
    ["<C-t>"] = custom_actions.multi_selection_open_tab,
    ["<S-d>"] = actions.delete_buffer,
    ["<C-e>"] = actions.preview_scrolling_up,
    -- ["<CR>"] = custom_actions.multi_selection_open,
    ["<CR>"] = function(pb)
      local picker = action_state.get_current_picker(pb)
      local multi = picker:get_multi_selection()
      actions.select_default(pb) -- the normal enter behaviour
      for _, j in pairs(multi) do
        if j.path ~= nil then -- is it a file -> open it as well:
          vim.cmd(string.format("%s %s", "edit", j.path))
        end
      end
    end,
    ["q"] = actions.close,
  },
}

return {
  "nvim-telescope/telescope.nvim",
  event = { "CmdlineEnter", "CursorHold" },
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    { "jvgrootveld/telescope-zoxide" },
    { "desdic/agrolens.nvim" },
  },
  opts = function()
    local get_icon = require("astroui").get_icon

    require("telescope").load_extension "agrolens"
    require("telescope").load_extension "egrepify"

    return {
      defaults = {
        prompt_prefix = string.format("%s ", get_icon "Search"),
        selection_caret = string.format("%s ", get_icon "Selected"),
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },

        vimgrep_arguments = {
          "rg",
          "--hidden",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },

        file_ignore_patterns = file_ignore_patterns,
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,

        file_sorter = require("telescope.sorters").get_fuzzy_file,
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,

        mappings = custom_mappings,
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
        agrolens = {
          debug = false,
          same_type = true,
          include_hidden_buffers = false,
          disable_indentation = false,
          aliases = {},
        },
      },
    }
  end,
}

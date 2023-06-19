function Hard_remap_mappings()
  local utils = require "astronvim.utils"

  local mappings_list = { i = {}, n = {}, v = {}, t = {} }

  mappings_list.n["<leader>fr"] =
    { function() require("telescope.builtin").oldfiles { cwd_only = true } end, desc = "Find recent files" }

  mappings_list.n["<leader>fg"] = { function() require("telescope.builtin").live_grep() end, desc = "Find grep" }

  utils.set_mappings(astronvim.user_opts("mappings", mappings_list))
end

local function cmd(str) return "<cmd>" .. str .. "<CR>" end

return {
  n = {
    ["<leader>bn"] = { cmd "tabnew", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<leader>b"] = { name = "Buffers" },
    ["<Tab>"] = { cmd "bnext" },
    ["<S-Tab>"] = { cmd "bprevious" },
    ["<Leader>fd"] = { cmd "Zeavim", desc = "Find documentation" },

    -- Telescope mappings
    ["<Leader>fB"] = { cmd "Telescope current_buffer_fuzzy_find", desc = "Find fuzzy in current buffer" },
    ["<Leader>fz"] = { cmd "Telescope zoxide list", desc = "Find zoxide" },
    ["<Leader>fw"] = { cmd "Telescope grep_string", desc = "Find string under cursor" },
    ["<Leader>fg"] = { cmd "Telescope live_grep", desc = "Find grep" },
    ["<Leader>fG"] = { cmd "Telescope live_grep hidden=true", desc = "Find grep with hidden" },
    ["<Leader>fr"] = { cmd "Telescope oldfiles cwd_only=true", desc = "Find recent files" },
    ["<Leader>fR"] = { cmd "Telescope oldfiles cwd_only=true hidden=true", desc = "Find recent files with hidden" },
    ["<Leader>fO"] = { cmd "Telescope registers", desc = "Find registers" },
    ["<Leader>fc"] = { cmd "Telescope neoclip a extra=star,plus,b", desc = "Find clipboard" },
    ["<Leader>fs"] = { cmd "Telescope git_status", desc = "Find git status" },
    ["<Leader>fa"] = {
      cmd "Telescope agrolens query=functions,callings,comments,labels buffers=all",
      desc = "Find TS query",
    },

    -- Renames all references to the symbol under the cursor
    ["<F2>"] = { cmd "lua require('cosmic-ui').rename()" },
    -- Selects a code action available at the current cursor position
    ["<F4>"] = { cmd "lua require('cosmic-ui').code_actions()" },
  },
  x = {
    ["<F4>"] = { cmd "lua require('cosmic-ui').range_code_actions()" },
  },
  i = {
    ["<C-s>"] = { cmd "write" },
    ["<C-e>"] = { "<End>" },
    ["<C-a>"] = { "<Home>" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}

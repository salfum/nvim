function Hard_remap_mappings()
  local utils = require "astronvim.utils"

  local mappings_list = { i = {}, n = {}, v = {}, t = {} }

  mappings_list.n["<leader>fr"] =
    { function() require("telescope.builtin").oldfiles { cwd_only = true } end, desc = "Find recent files" }

  mappings_list.n["<leader>fg"] = { function() require("telescope.builtin").live_grep() end, desc = "Find grep" }

  utils.set_mappings(astronvim.user_opts("mappings", mappings_list))
end

return {
  n = {
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<leader>b"] = { name = "Buffers" },
    ["<Tab>"] = { "<cmd>bnext<cr>" },
    ["<S-Tab>"] = { "<cmd>bprevious<cr>" },
    ["<Leader>fd"] = { "<cmd>Zeavim<cr>", desc = "Find documentation" },

    -- Telescope mappings
    ["<Leader>fB"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find fuzzy in current buffer" },
    ["<Leader>fz"] = { "<cmd>Telescope zoxide list<cr>", desc = "Find zoxide" },
    ["<Leader>fw"] = { "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor" },
    ["<Leader>fg"] = { "<cmd>Telescope live_grep<cr>", desc = "Find grep" },
    ["<Leader>fG"] = { "<cmd>Telescope live_grep hidden=true<cr>", desc = "Find grep with hidden" },
    ["<Leader>fr"] = { "<cmd>Telescope oldfiles cwd_only=true<cr>", desc = "Find recent files" },
    ["<Leader>fR"] = { "<cmd>Telescope oldfiles cwd_only=true hidden=true<cr>", desc = "Find recent files with hidden" },
    ["<Leader>fO"] = { "<cmd>Telescope registers<CR>", desc = "Find registers" },
    ["<Leader>fc"] = { "<cmd>Telescope neoclip a extra=star,plus,b<cr>", desc = "Find clipboard" },
    ["<Leader>fs"] = { "<cmd>Telescope git_status<cr>", desc = "Find git status" },
    ["<Leader>fa"] = {
      "<cmd>Telescope agrolens query=functions,callings,comments,labels buffers=all<cr>",
      desc = "Find TS query",
    },

    -- Renames all references to the symbol under the cursor
    ["<F2>"] = { '<cmd>lua require("cosmic-ui").rename()<cr>' },
    -- Selects a code action available at the current cursor position
    ["<F4>"] = { '<cmd>lua require("cosmic-ui").code_actions()<cr>' },
  },
  x = {
    ["<F4>"] = { '<cmd>lua require("cosmic-ui").range_code_actions()<cr>' },
  },
  i = {
    ["<C-s>"] = { "<cmd>write<cr>" },
    ["<C-e>"] = { "<End>" },
    ["<C-a>"] = { "<Home>" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}

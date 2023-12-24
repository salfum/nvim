function Hard_remap_mappings()
  local utils = require("astronvim.utils")

  local mappings_list = { i = {}, n = {}, v = {}, t = {} }

  mappings_list.n["<leader>fr"] = {
    function() require("telescope.builtin").oldfiles({ cwd_only = true }) end,
    desc = "Find recent files",
  }

  mappings_list.n["<leader>fg"] = {
    "<cmd>Telescope egrepify<cr>",
    desc = "Find grep",
  }

  mappings_list.n["<leader>ff"] = {
    function() require("telescope").extensions.smart_open.smart_open({ cwd_only = true }) end,
    desc = "Find smart",
  }

  if vim.g.neovide then
    vim.keymap.set("n", "<C-s>", ":w<CR>") -- Save
    vim.keymap.set("v", "<C-c>", '"+y') -- Copy
    vim.keymap.set("n", "<C-v>", '"+P') -- Paste normal mode
    vim.keymap.set("v", "<C-v>", '"+P') -- Paste visual mode
    vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
    vim.keymap.set("i", "<C-v>", '<ESC>l"+Pli') -- Paste insert mode
  end

  -- Allow clipboard copy paste in neovim
  vim.api.nvim_set_keymap("", "<C-v>", "+p<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("!", "<C-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("t", "<C-v>", "<C-R>+", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("v", "<C-v>", "<C-R>+", { noremap = true, silent = true })

  utils.set_mappings(astronvim.user_opts("mappings", mappings_list))
end

local function cmd(str) return "<cmd>" .. str .. "<CR>" end

local function delete_under()
  local row, col = unpack(vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win()))
  vim.cmd.normal("i")
  vim.cmd.normal("dd")
  vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { row - 1, col })
end

local function delete_over()
  local row, col = unpack(vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win()))
  vim.cmd.normal("k")
  vim.cmd.normal("dd")
  vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { row, col })
end

return {
  n = {
    -- Split movements
    ["<C-S-i>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
    ["<C-S-j>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    ["<C-S-k>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
    ["<C-S-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },

    -- File movements
    ["<C-k>"] = { "<C-u>zz", desc = "Move screen top" },
    ["<C-h>"] = { "zh", desc = "Move screen left" },
    ["<C-j>"] = { "<C-d>zz", desc = "Move screen down" },
    ["<C-l>"] = { "zl", desc = "Move screen right" },

    ["<leader>bn"] = { cmd("tabnew"), desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<leader>b"] = { name = "Buffers" },
    ["<Tab>"] = { cmd("bnext") },
    ["<S-Tab>"] = { cmd("bprevious") },
    ["<Leader>fd"] = { cmd("Zeavim"), desc = "Find documentation" },

    -- Bookmarks
    ["<leader>a"] = { name = "Bookmarks" },
    ["<leader>aa"] = { cmd("lua require'bookmarks'.add_bookmarks()"), desc = "Add bookmark" },
    ["<leader>at"] = { cmd("lua require'bookmarks'.toggle_bookmarks()"), desc = "Toggle bookmarks" },
    ["<leader>ad"] = { cmd("lua require'bookmarks.list'.delete_on_virt()"), desc = "Delete bookmark" },
    ["<leader>as"] = { cmd("lua require'bookmarks.list'.show_desc()"), desc = "Show bookmark description" },
    ["<leader>af"] = { cmd("Telescope bookmarks"), desc = "Bookmarks list" },

    -- Telescope mappings
    ["<Leader>fB"] = { cmd("Telescope current_buffer_fuzzy_find"), desc = "Find fuzzy in current buffer" },
    ["<Leader>fz"] = { cmd("Telescope zoxide list"), desc = "Find zoxide" },
    ["<Leader>fw"] = { cmd("Telescope grep_string"), desc = "Find string under cursor" },
    ["<Leader>fg"] = { cmd("Telescope live_grep"), desc = "Find grep" },
    ["<Leader>fG"] = { cmd("Telescope live_grep hidden=true"), desc = "Find grep with hidden" },
    ["<Leader>fr"] = { cmd("Telescope oldfiles cwd_only=true"), desc = "Find recent files" },
    ["<Leader>fR"] = { cmd("Telescope oldfiles cwd_only=true hidden=true"), desc = "Find recent files with hidden" },
    ["<Leader>fO"] = { cmd("Telescope registers"), desc = "Find registers" },
    ["<Leader>fc"] = { cmd("Telescope neoclip a extra=star,plus,b"), desc = "Find clipboard" },
    ["<Leader>fs"] = { cmd("Telescope git_status"), desc = "Find git status" },
    ["<Leader>fa"] = {
      cmd("Telescope agrolens query=functions,callings,comments,labels buffers=all"),
      desc = "Find TS query",
    },

    -- lsp_lines
    ["<Leader>L"] = { cmd("lua require('lsp_lines').toggle()"), desc = "Toogle lsp_lines" },

    -- Renames all references to the symbol under the cursor
    ["<F2>"] = { cmd("lua require('cosmic-ui').rename()") },
    -- Selects a code action available at the current cursor position
    ["<F4>"] = { cmd("lua require('cosmic-ui').code_actions()") },

    -- New remaps
    ["<leader>E"] = { vim.cmd.Ex }, -- Open vim file manager
    ["J"] = { "mzJ`z" },
    ["n"] = { "nzzzv" },
    ["N"] = { "Nzzzv" },
  },
  x = {
    ["<F4>"] = { cmd("lua require('cosmic-ui').range_code_actions()") },
  },
  i = {
    ["<C-s>"] = { cmd("write") },
    ["<C-e>"] = { "<End>" },
    ["<C-a>"] = { "<Home>" },

    -- insert mode delete mirrors
    ["<C-j>"] = { function() delete_under() end },
    ["<C-h>"] = { "<BS>" },
    ["<C-k>"] = { function() delete_over() end },
    ["<C-l>"] = { "<Delete>" },
  },
  t = {
    ["<C-i>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}

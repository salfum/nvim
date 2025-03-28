local helpers = require "helpers"
local cmd = helpers.cmd

-- Allow clipboard copy paste in neovim
vim.api.nvim_set_keymap("", "<C-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-v>", "<C-R>+", { noremap = true, silent = true })

if vim.g.neovide then
  vim.keymap.set("n", "<C-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<C-c>", '"+y') -- Copy
  vim.keymap.set("n", "<C-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<C-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<C-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<C-v>", '<ESC>l"+Pli') -- Paste insert mode
end

vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", { noremap = true, silent = true })

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
vim.keymap.set("n", "F4", vim.lsp.buf.code_action, opts)

vim.cmd "nnoremap <C-e> <Nop>"

return {
  n = {
    -- navigate buffer tabs with `H` and `L`
    L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
    H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

    -- mappings seen under group name "Buffer"
    ["<Leader>bD"] = {
      function()
        require("astroui.status.heirline").buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with just a `desc` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<Leader>b"] = { desc = "Buffers" },
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
    ["<Esc>"] = { "<cmd>noh<CR>", desc = "Clear search highlight" },
    -- old n mappings

    -- Split movements
    ["<C-S-h>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
    ["<C-S-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
    ["<C-S-k>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    ["<C-S-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },

    ["<leader>bn"] = { cmd "tabnew", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<Tab>"] = { cmd "bnext" },
    ["<S-Tab>"] = { cmd "bprevious" },
    ["<Leader>fd"] = { cmd "Zeavim", desc = "Find documentation" },

    -- File movements
    -- ["<C-k>"] = {
    --   function()
    --     vim.cmd [[norm! 10k]]
    --     vim.cmd [[norm! zz]]
    --   end,
    --   desc = "Move screen top",
    -- },
    ["<C-h>"] = { "zh", desc = "Move screen left" },
    -- ["<C-j>"] = {
    --   function()
    --     vim.cmd [[norm! 10j]]
    --     vim.cmd [[norm! zz]]
    --   end,
    --   desc = "Move screen down",
    -- },
    ["<C-l>"] = { "zl", desc = "Move screen right" },

    -- ["<C-j>"] = { "<C-d>zz" },
    -- ["<C-k>"] = { "<C-u>zz" },

    ["<C-e>"] = { "<C-u>zz", noremap = true },

    ["<Leader><Leader>"] = { "<C-^>" },
    ["zZ"] = { cmd [[:NoNeckPain]], noremap = true },

    -- Bookmarks
    -- ["<leader>a"] = { name = "Bookmarks" },
    -- ["<leader>aa"] = { cmd "lua require'bookmarks'.add_bookmarks()", desc = "Add bookmark" },
    -- ["<leader>at"] = { cmd "lua require'bookmarks'.toggle_bookmarks()", desc = "Toggle bookmarks" },
    -- ["<leader>ad"] = { cmd "lua require'bookmarks.list'.delete_on_virt()", desc = "Delete bookmark" },
    -- ["<leader>as"] = { cmd "lua require'bookmarks.list'.show_desc()", desc = "Show bookmark description" },
    -- ["<leader>af"] = { cmd "Telescope bookmarks", desc = "Bookmarks list" },

    -- Telescope remaps
    ["<leader>fr"] = {
      function() require("telescope.builtin").oldfiles { cwd_only = true } end,
      desc = "Find recent files",
    },
    ["<leader>fg"] = {
      "<cmd>Telescope egrepify<cr>",
      desc = "Find grep",
    },
    ["<leader>ff"] = {
      function() require("telescope").extensions.smart_open.smart_open { cwd_only = true } end,
      desc = "Find smart",
      noremap = true,
    },

    -- Telescope mappings
    ["<Leader>fB"] = { cmd "Telescope current_buffer_fuzzy_find", desc = "Find fuzzy in current buffer" },
    ["<Leader>fz"] = { cmd "Telescope zoxide list", desc = "Find zoxide" },
    ["<Leader>fw"] = { cmd "Telescope grep_string", desc = "Find string under cursor", noremap = true },
    ["<Leader>fg"] = { cmd "Telescope live_grep", desc = "Find grep" },
    ["<Leader>fG"] = { cmd "Telescope live_grep hidden=true", desc = "Find grep with hidden" },
    ["<Leader>fR"] = { cmd "Telescope oldfiles cwd_only=true hidden=true", desc = "Find recent files with hidden" },
    ["<Leader>fO"] = { cmd "Telescope registers", desc = "Find registers" },
    ["<Leader>fc"] = { cmd "Telescope neoclip a extra=star,plus,b", desc = "Find clipboard" },
    ["<Leader>fs"] = { cmd "Telescope git_status", desc = "Find git status" },
    ["<Leader>fa"] = {
      cmd "Telescope agrolens query=functions,callings,comments,labels buffers=all",
      desc = "Find TS query",
    },
    ["<Leader>F"] = {
      cmd "Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal",
      desc = "Find buffers",
      noremap = true,
    },

    -- vim-test
    ["<Leader>Tt"] = { cmd "TestNearest", desc = "Run nearest test in background" },
    ["<Leader>Tr"] = { cmd "TestLast", desc = "Run latest test in background" },
    ["<Leader>Tf"] = { cmd "TestFile", desc = "Run tests in file" },

    -- lsp_lines
    -- ["<Leader>L"] = { cmd("lua require('lsp_lines').toggle()"), desc = "Toogle lsp_lines" },

    -- Oil.nvim
    ["-"] = { cmd "Oil", desc = "Open parent directory" },

    -- Renames all references to the symbol under the cursor
    ["<F2>"] = { cmd "lua require('cosmic-ui').rename()" },
    -- Selects a code action available at the current cursor position
    ["<F4>"] = { cmd "lua require('cosmic-ui').code_actions()" },

    -- New remaps
    ["J"] = { "mzJ`z" },
    -- ["n"] = { "nzzzv" },
    -- ["N"] = { "Nzzzv" },
    -- ["#"] = { "#zz" },
    -- ["*"] = { "*zz" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
    ["<C-i>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
  },
  v = {
    ["<Leader>fw"] = {
      function()
        local selection = helpers.get_visual_selection()
        require("telescope.builtin").live_grep { default_text = selection }
      end,
      desc = "Find string under cursor",
    },
  },
  x = {
    ["<F4>"] = { cmd "lua require('cosmic-ui').range_code_actions()" },
  },
  i = {
    ["<C-s>"] = { cmd "write" },
    ["<C-e>"] = { "<End>" },
    ["<C-a>"] = { "<Home>" },

    -- insert mode delete mirrors
    -- ["<C-j>"] = { function() helpers.delete_under() end },
    ["<C-h>"] = { "<BS>" },
    -- ["<C-k>"] = { function() helpers.delete_over() end },
    ["<C-l>"] = { "<Delete>" },
  },
}

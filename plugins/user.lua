return {
  { "mg979/vim-visual-multi", event = "User AstroFile" },
  { "AckslD/nvim-neoclip.lua", event = "User VeryLazy", opts = {} },
  { "CosmicNvim/cosmic-ui", dependencies = { "MunifTanjim/nui.nvim" }, opts = {} },
  { "ivanesmantovich/xkbswitch.nvim", event = "User AstroFile", opts = {} },
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "User AstroFile" },
  -- { "kevinhwang91/nvim-hlslens", event = "User AstroFile", opts = {} },
  { "KabbAmine/zeavim.vim", cmd = "Zeavim", config = function() vim.g.zv_zeal_args = "--style=kvantum" end },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", desc = "Spider-w", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", desc = "Spider-e", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", desc = "Spider-b", mode = { "n", "o", "x" } },
      { "ge", "<cmd>lua require('spider').motion('ge')<CR>", desc = "Spider-ge", mode = { "n", "o", "x" } },
    },
  },
  {
    "danielfalk/smart-open.nvim",
    branch = "0.2.x",
    config = function() require("telescope").load_extension("smart_open") end,
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User AstroFile",
    opts = {},
  },
  {
    "lewis6991/satellite.nvim",
    -- tag = "v1.0.0",
    -- branch = "incre",
    -- branch = "neovim>=0.7.0",
    event = "User AstroFile",
    opts = {},
  },
  { "shortcuts/no-neck-pain.nvim", version = "*", event = "User AstroFile" },
  {
    "VidocqH/lsp-lens.nvim",
    opts = {
      sections = {
        definition = function(count) return "Definitions: " .. count end,
        references = function(count) return "References: " .. count end,
        implements = function(count) return "Implements: " .. count end,
        git_authors = function(latest_author, count)
          return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
        end,
      },
    },
  },
  {
    "PHSix/faster.nvim",
    event = { "VimEnter *" },
    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(faster_move_j)", { noremap = false, silent = true })
      vim.api.nvim_set_keymap("n", "k", "<Plug>(faster_move_k)", { noremap = false, silent = true })
    end,
  },
  -- {
  --   "rmagatti/auto-session",
  --   event = "VimEnter",
  --   opts = {
  --     log_level = "error",
  --     auto_save_enabled = true,
  --     auto_restore_enabled = true,
  --     -- auto_session_root_dir = "~/code/nvim_sessions/",
  --     auto_session_suppress_dirs = { "~/", "~/code", "~/projects", "~/Downloads", "/" },
  --     auto_session_use_git_branch = true,
  --   },
  -- },
  {
    "axkirillov/hbac.nvim",
    event = "User VeryLazy",
    opts = {
      autoclose = true, -- set autoclose to false if you want to close manually
      threshold = 10, -- hbac will start closing unedited buffers once that number is reached
      close_command = function(bufnr) vim.api.nvim_buf_delete(bufnr, {}) end,
      close_buffers_with_windows = false, -- hbac will close buffers with associated windows if this option is `true`
    },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "BufReadPost",
    opts = {},
  },
  {
    "olimorris/persisted.nvim",
    event = "VimEnter",
    lazy = true,
    cmd = {
      "SessionToggle",
      "SessionStart",
      "SessionStop",
      "SessionSave",
      "SessionLoad",
      "SessionLoadLast",
      "SessionLoadFromFile",
      "SessionDelete",
    },
    silent = true,
    opts = {
      autosave = true,
      use_git_branch = true,
      autoload = true,
      ignored_dirs = { "~/", "~/code", "~/projects", "~/Downloads", "/" },
    },
  },
  {
    "hinell/lsp-timeout.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "fdschmidt93/telescope-egrepify.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  { "shortcuts/no-neck-pain.nvim", version = "*" },
  { "EtiamNullam/gradual-undo.nvim", opts = {} },
  { "nacro90/numb.nvim", event = "BufReadPost", opts = {} },
}

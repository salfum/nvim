---@type LazySpec
return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        [[╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮]],
        [[│││├┤ │ │╰┐┌╯││││]],
        [[╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴]],
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  -- v3 plugins

  { "mg979/vim-visual-multi", event = "User AstroFile" },
  { "CosmicNvim/cosmic-ui", dependencies = { "MunifTanjim/nui.nvim" }, opts = {} },
  { "ivanesmantovich/xkbswitch.nvim", event = "User AstroFile", opts = {} },
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
    config = function() require("telescope").load_extension "smart_open" end,
    dependencies = {
      "kkharji/sqlite.lua",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
  {
    "lewis6991/satellite.nvim",
    -- tag = "v1.0.0",
    -- branch = "incre",
    -- branch = "neovim>=0.7.0",
    event = "User AstroFile",
    opts = {},
  },
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    event = "User AstroFile",
    opts = {
      buffers = {
        right = {
          enabled = false,
        },
        -- scratchPad = {
        --   -- set to `false` to
        --   -- disable auto-saving
        --   enabled = true,
        --   -- set to `nil` to default
        --   -- to current working directory
        --   location = "~/Documents/nvim",
        -- },
        -- bo = {
        --   filetype = "md",
        -- },
      },
    },
  },
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
    "fdschmidt93/telescope-egrepify.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "stevearc/oil.nvim",
    event = "User VeryLazy",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestLast", "TestFile" },
    config = function()
      vim.cmd [[
        let g:test#strategy = 'toggleterm'
      ]]
    end,
  },
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      vim.keymap.set("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end, { expr = true, silent = true })
      vim.keymap.set(
        "i",
        "<c-;>",
        function() return vim.fn["codeium#CycleCompletions"](1) end,
        { expr = true, silent = true }
      )
      vim.keymap.set(
        "i",
        "<c-,>",
        function() return vim.fn["codeium#CycleCompletions"](-1) end,
        { expr = true, silent = true }
      )
      vim.keymap.set("i", "<c-x>", function() return vim.fn["codeium#Clear"]() end, { expr = true, silent = true })
    end,
  },
  {
    "sontungexpt/stcursorword",
    event = "VeryLazy",
    config = true,
  },
  {
    "sainnhe/gruvbox-material",
    event = "VimEnter",
    config = function() vim.g.gruvbox_material_background = "hard" end,
  },
  {
    "vim-crystal/vim-crystal",
    ft = { "crystal" },
  },
  {
    "pteroctopus/faster.nvim",
    opts = {},
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- timeout in milliseconds
        temperature = 0, -- adjust if needed
        max_tokens = 4096,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  -- {
  --   "nvim-treesitter/nvim-treesitter-context",
  --   event = "User AstroFile",
  --   opts = {},
  -- },
  -- {
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   event = "BufReadPost",
  --   opts = {},
  -- },
  -- {
  --   "hinell/lsp-timeout.nvim",
  --   event = "User AstroFile",
  --   dependencies = { "neovim/nvim-lspconfig" },
  --   init = function()
  --     vim.g.lspTimeoutConfig = {
  --       -- stopTimeout = 1000 * 60 * 5, -- ms, timeout before stopping all LSPs
  --       stopTimeout = 1000 * 60 * 2, -- ms, timeout before stopping all LSPs
  --       startTimeout = 1000 * 2, -- ms, timeout before restart
  --       silent = false, -- true to suppress notifications
  --     }
  --   end,
  -- },
  -- {
  --   "VidocqH/lsp-lens.nvim",
  --   opts = {
  --     sections = {
  --       definition = function(count) return "Definitions: " .. count end,
  --       references = function(count) return "References: " .. count end,
  --       implements = function(count) return "Implements: " .. count end,
  --       git_authors = function(latest_author, count)
  --         return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
  --       end,
  --     },
  --   },
  -- },
  -- { "nvim-treesitter/nvim-treesitter-textobjects", event = "User AstroFile" },
  -- { "kevinhwang91/nvim-hlslens", event = "User AstroFile", opts = {} },
  -- { "KabbAmine/zeavim.vim", cmd = "Zeavim", config = function() vim.g.zv_zeal_args = "--style=kvantum" end },
}

return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false, -- automatically quit the current session after a successful update
    remotes = { -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  colorscheme = "terafox",

  diagnostics = {
    virtual_text = true,
    signs = true,
    underline = true,
    severity_sort = false,
  },

  lsp = {
    formatting = {
      format_on_save = {
        enabled = true,
        ignore_filetypes = {
          "elixir",
        },
      },
      disabled = {
        "lua_ls",
      },
      timeout_ms = 3000,
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {},
    config = {
      clangd = function(opts)
        opts.cmd = {
          "clangd",
          "--offset-encoding=utf-16",
        }
        return opts
      end,
    },
  },

  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = {
          "2html_plugin",
          "bugreport",
          "compiler",
          -- 'ftplugin',
          "getscript",
          "getscriptPlugin",
          "gzip",
          "logiPat",
          "logipat",
          "matchit",
          "matchparen",
          -- 'netrw',
          -- 'netrwFileHandlers',
          -- 'netrwPlugin',
          -- 'netrwSettings',
          "optwin",
          "remote_plugins",
          "rplugin",
          "rrhelper",
          "synmenu",
          "syntax",
          "tar",
          "tarPlugin",
          "tohtml",
          "tutor",
          "tutor_mode_plugin",
          "vimball",
          "vimballPlugin",
          "zip",
          "zipPlugin",
        },
      },
    },
  },

  polish = function()
    --- Automatic toggle relative numbers between modes
    local function relativenumber_autotoggle()
      local group = vim.api.nvim_create_augroup("RelativeNumberToggle", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
        pattern = "*",
        group = group,
        command = 'if &nu && mode() != "i" | set rnu | endif',
      })

      vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
        pattern = "*",
        group = group,
        command = "if &nu | set nornu | endif",
      })
    end
    relativenumber_autotoggle()

    Hard_remap_mappings() -- final remap default mappings
  end,
}

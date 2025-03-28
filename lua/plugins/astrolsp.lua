---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      autoformat = true, -- enable or disable auto formatting on start
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = false, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    formatting = {
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "elixir",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        "lua_ls",
        "lexical",
      },
      timeout_ms = 3000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "lexical",
      -- "nextls",
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      clangd = { capabilities = { offsetEncoding = "utf-8" } },
      nextls = {},
      -- clangd = function(opts)
      --   opts.cmd = {
      --     "clangd",
      --     "--offset-encoding=utf-16",
      --   }
      --   return opts
      -- end,
      -- nextls = {},
    },
    -- customize how language servers are attached
    handlers = {
      -- a function without a key is simply the default handler, functions take two parameters, the server name and the configured options table for that server
      -- function(server, opts) require("lspconfig")[server].setup(opts) end

      -- the key is the server that is being setup with `lspconfig`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
      -- pyright = function(_, opts) require("lspconfig").pyright.setup(opts) end -- or a custom handler function can be passed
      -- lexical = function(_, opts)
      --   local lexical_config = {
      --     filetypes = { "elixir", "eelixir", "heex" },
      --     cmd = { os.getenv "LEXICAL_EXECUTABLE_PATH" },
      --     settings = {},
      --   }
      --
      --   -- require("lsp_signature").setup {}
      --
      --   return require("lspconfig").lexical.setup(require("astrocore").extend_tbl({
      --     filetypes = lexical_config.filetypes,
      --     cmd = lexical_config.cmd,
      --     root_dir = require("lspconfig.util").root_pattern { "mix.exs", ".git" } or vim.loop.os_homedir(),
      --     settings = lexical_config.settings,
      --   }, opts))
      -- end,
      emmet_ls = function(_, opts)
        opts.filetypes = require("astrocore").list_insert_unique(opts.filetypes, { "heex" })

        return require("lspconfig").emmet_ls.setup(opts)
      end,
      -- nextls = function(_, opts)
      -- print inspect opts
      -- print(vim.inspect(opts))
      -- local nextls_config = {
      --   -- port = 9000, -- connect via TCP with the given port. mutually exclusive with `cmd`. defaults to nil
      --   -- filetypes = { "elixir", "eelixir", "heex" },
      --   cmd = os.getenv "NEXTLS_EXECUTABLE_PATH",
      --   init_options = {
      --     mix_env = "dev",
      --     mix_target = "host",
      --     experimental = {
      --       completions = {
      --         enable = true,
      --       },
      --     },
      --   },
      -- }
      --
      -- local nextls_config2 = {
      --   default_config = {
      --     filetypes = { "elixir", "eelixir", "heex" },
      --     -- cmd = mason_registry.get_install_path("nextls"),
      --     cmd = { os.getenv "NEXTLS_EXECUTABLE_PATH", "--stdio" },
      --     cmd_env = { NEXTLS_SPITFIRE_ENABLED = "1" },
      --     root_dir = require("lspconfig").util.root_pattern("mix.lock", ".git"),
      --     settings = {
      --       extensions = {
      --         credo = {
      --           enable = true,
      --         },
      --       },
      --       experimental = {
      --         completions = {
      --           enable = true,
      --         },
      --       },
      --     },
      --   },
      -- }

      -- return require("lspconfig").nextls.setup(require("astrocore").extend_tbl({
      --   filetypes = nextls_config.filetypes,
      --   cmd = nextls_config.cmd,
      --   root_dir = require("lspconfig.util").root_pattern { "mix.exs", ".git" } or vim.loop.os_homedir(),
      --   init_options = nextls_config.init_options,
      -- }, opts))

      -- return require("elixir.nextls").setup(nextls_config2)
      -- end,
    },
    -- Configure buffer local auto commands to add when attaching a language server
    autocmds = {
      -- first key is the `augroup` to add the auto commands to (:h augroup)
      lsp_document_highlight = {
        -- Optional condition to create/delete auto command group
        -- can either be a string of a client capability or a function of `fun(client, bufnr): boolean`
        -- condition will be resolved for each client on each execution and if it ever fails for all clients,
        -- the auto commands will be deleted for that buffer
        cond = "textDocument/documentHighlight",
        -- cond = function(client, bufnr) return client.name == "lua_ls" end,
        -- list of auto commands to set
        {
          -- events to trigger
          event = { "CursorHold", "CursorHoldI" },
          -- the rest of the autocmd options (:h nvim_create_autocmd)
          desc = "Document Highlighting",
          callback = function() vim.lsp.buf.document_highlight() end,
        },
        {
          event = { "CursorMoved", "CursorMovedI", "BufLeave" },
          desc = "Document Highlighting Clear",
          callback = function() vim.lsp.buf.clear_references() end,
        },
      },
    },
    -- mappings to be set up on attaching of a language server
    mappings = {
      n = {
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        gd = { "<cmd>Telescope lsp_definitions<cr>", desc = "Go to definition", noremap = true, silent = true },
        gr = { "<cmd>Telescope lsp_references<cr>", desc = "Go to reference", noremap = true, silent = true },
        gD = {
          "<cmd>Telescope lsp_type_definitions<cr>",
          desc = "Go to type definition",
          noremap = true,
          silent = true,
        },
        gi = { "<cmd>Telescope lsp_implementations<cr>", desc = "Go to implementation", noremap = true, silent = true },
        gt = { "<cmd>Telescope lsp_document_symbols<cr>", desc = "Go to symbol", noremap = true, silent = true },
        gT = {
          "<cmd>Telescope lsp_workspace_symbols<cr>",
          desc = "Go to workspace symbol",
          noremap = true,
          silent = true,
        },
        K = { vim.lsp.buf.hover, desc = "Hover", noremap = true, silent = true },
        -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
        -- gD = {
        --   function() vim.lsp.buf.declaration() end,
        --   desc = "Declaration of current symbol",
        --   cond = "textDocument/declaration",
        -- },
        -- ["<Leader>uY"] = {
        --   function() require("astrolsp.toggles").buffer_semantic_tokens() end,
        --   desc = "Toggle LSP semantic highlight (buffer)",
        --   cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        -- },
      },
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lspconfig-setup`)
    on_attach = function(_client, _bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  },
}

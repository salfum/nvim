---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    }

    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "bash",
      "c",
      "c_sharp",
      "cpp",
      "css",
      "clojure",
      "cmake",
      "comment",
      "d",
      "dockerfile",
      "eex",
      "elixir",
      "erlang",
      "gitignore",
      "gleam",
      "graphql",
      "haskell",
      "heex",
      "html",
      "http",
      "java",
      "javascript",
      "json",
      "json5",
      "jsonc",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "nix",
      "ocaml",
      "php",
      "query",
      "regex",
      "ruby",
      "rust",
      "scala",
      "scheme",
      "scss",
      "sql",
      "surface",
      "toml",
      "typescript",
      "vala",
      "vim",
      "vue",
      "zig",
    })
  end,
}

return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.nightfox-nvim", enabled = true },
  -- { import = "astrocommunity.syntax.hlargs-nvim" }, -- does not support elixir yet :c
  { import = "astrocommunity.search.nvim-hlslens" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.motion.leap-nvim" },
  -- { import = "astrocommunity.workflow.hardtime-nvim" }, -- maybe later c:
  -- langs
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.php" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.lua" },
}

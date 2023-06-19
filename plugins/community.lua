return {
  -- Add the community repository of plugin specifications
  -- https://github.com/AstroNvim/astrocommunity
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.colorscheme.nightfox-nvim", enabled = true },
  { import = "astrocommunity.syntax.hlargs-nvim" },
  { import = "astrocommunity.markdown-and-latex.markdown-preview-nvim" },
  { import = "astrocommunity.scrolling.satellite-nvim" },
  { import = "astrocommunity.project.nvim-spectre" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.motion.leap-nvim" },
  -- langs
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.php" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.lua" },
}

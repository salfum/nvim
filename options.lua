return {
  opt = {
    relativenumber = true, -- sets vim.opt.relativenumber
    number = true, -- sets vim.opt.number
    spell = false, -- sets vim.opt.spell
    signcolumn = "auto", -- sets vim.opt.signcolumn to auto
    wrap = false, -- sets vim.opt.wrap

    grepprg = "rg --hidden --vimgrep --smart-case --",
    guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20,o:hor50",
    guifont = { "FiraCode Nerd Font Mono", ":h13" },
    history = 2000,
    jumpoptions = "stack",
    lazyredraw = true,
    magic = true,
    sessionoptions = "curdir,help,tabpages,winsize",
    shada = "!,'300,<50,@100,s10,h",
    shiftround = true,
    shortmess = "aoOTIcF",
    showmode = false,
    showtabline = 2,
    sidescrolloff = 5,
    smartcase = true,
    smartindent = true,
  },
  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements

    -- clients and plugin hosts settings
    python2 = "/usr/bin/python2",
    python3 = "/usr/bin/python3",
    python_host_prog = "/usr/bin/python2",
    python3_host_prog = "/usr/bin/python3",
    loaded_node_provider = 0,
    loaded_ruby_provider = 0,
    loaded_perl_provider = 0,
  },
}
-- If you need more control, you can use the function()...end notation
-- return function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end

local custom = function()
  local neovide = function()
    if not vim.g.neovide then return {} end

    -- local transparency = 0.98
    -- local alpha = function() return string.format("%x", math.floor(255 * transparency)) end

    return {
      g = {
        -- neovide_transparency = transparency, -- should be 0 if you want to unify transparency of content and title bar.
        -- transparency = transparency,
        -- neovide_background_color = "#0f1117" .. alpha(),
        neovide_hide_mouse_when_typing = true,
        neovide_underline_automatic_scaling = false,
        neovide_scroll_animation_length = 0,
        neovide_cursor_animation_length = 0.13,
        neovide_cursor_animate_command_line = false,
        neovide_cursor_vfx_mode = "pixiedust",
        neovide_cursor_vfx_particle_density = 13.0,
      },
    }
  end

  return neovide()
end

local options = {
  opt = {
    relativenumber = false, -- sets vim.opt.relativenumber
    number = false, -- sets vim.opt.number
    spell = false, -- sets vim.opt.spell
    signcolumn = "auto", -- sets vim.opt.signcolumn to auto
    wrap = false, -- sets vim.opt.wrap

    -- v3 options
    grepprg = "rg --hidden --vimgrep --smart-case --",
    guicursor = "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor/lCursor,r-cr:hor20,o:hor50",
    guifont = { "FiraCode Nerd Font Mono", ":h13" },
    -- guifont = { "Inter Nerd Font Propo", ":h13" },
    -- guifont = { "BlexMono Nerd Font", ":h13" },
    history = 2000,
    jumpoptions = "stack",
    lazyredraw = false,
    magic = true,
    -- sessionoptions = "curdir,help,tabpages,winsize",
    shada = "!,'300,<50,@100,s10,h",
    shiftround = true,
    shortmess = "aoOTIcF",
    showmode = false,
    showtabline = 2,
    sidescrolloff = 5,
    smartcase = true,
    smartindent = true,
    swapfile = false,
  },
  g = {
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

return require("astrocore").extend_tbl(options, custom())

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

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

local function colorize_telescope()
  local get_hlgroup = require("astroui").get_hlgroup

  local normal = get_hlgroup "Normal"
  local fg, bg = normal.fg, normal.bg
  local bg_alt = get_hlgroup("Visual").bg
  local green = get_hlgroup("String").fg
  local red = get_hlgroup("Error").fg

  local highlights = {
    TelescopeBorder = { fg = bg_alt, bg = bg },
    TelescopeNormal = { bg = bg },
    TelescopePreviewBorder = { fg = bg, bg = bg },
    TelescopePreviewNormal = { bg = bg },
    TelescopePreviewTitle = { fg = bg, bg = green },
    TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
    TelescopePromptNormal = { fg = fg, bg = bg_alt },
    TelescopePromptPrefix = { fg = red, bg = bg_alt },
    TelescopePromptTitle = { fg = bg, bg = red },
    TelescopeResultsBorder = { fg = bg, bg = bg },
    TelescopeResultsNormal = { bg = bg },
    TelescopeResultsTitle = { fg = bg, bg = bg },
  }

  for k, v in pairs(highlights) do
    vim.api.nvim_set_hl(0, k, v)
  end
end

relativenumber_autotoggle()
colorize_telescope()

vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles cwd_only=true<cr>")

vim.cmd [[autocmd CursorHold <buffer> lua vim.diagnostic.open_float({focusable = false})]]

vim.opt.showtabline = 0

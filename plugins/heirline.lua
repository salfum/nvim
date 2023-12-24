return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    opts.winbar = nil
    opts.tabline = nil
    vim.opt.showtabline = 0
    return opts
  end,
}

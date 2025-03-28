local M = {}

function M.cmd(str) return "<cmd>" .. str .. "<CR>" end

function M.delete_under()
  local row, col = unpack(vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win()))
  vim.cmd.normal("i")
  vim.cmd.normal("dd")
  vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { row - 1, col })
end

function M.delete_over()
  local row, col = unpack(vim.api.nvim_win_get_cursor(vim.api.nvim_get_current_win()))
  vim.cmd.normal("k")
  vim.cmd.normal("dd")
  vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { row, col })
end

function M.get_visual_selection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg("v")
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

return M

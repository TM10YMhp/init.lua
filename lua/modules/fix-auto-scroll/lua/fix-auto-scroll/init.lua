local api = vim.api
local var_name = "fix_auto_scroll"

local M = {}

function M.save()
  if not vim.list_contains({ "" }, vim.o.buftype) then return end

  local value = vim.fn.winsaveview()
  api.nvim_buf_set_var(0, var_name, value)
end

function M.restore()
  if not vim.list_contains({ "" }, vim.o.buftype) then return end

  local ok, value = pcall(api.nvim_buf_get_var, 0, var_name)

  if not ok then return end

  local v = vim.fn.winsaveview()
  local at_start_of_file = v.lnum == 1 and v.col == 0
  if at_start_of_file and not vim.api.nvim_get_option_value("diff", {}) then
    vim.fn.winrestview(value)
  end

  api.nvim_buf_del_var(0, var_name)
end

function M.setup()
  local save_view_group = vim.api.nvim_create_augroup("sn.save_view", {})
  vim.api.nvim_create_autocmd("BufEnter", {
    group = save_view_group,
    callback = function() M.restore() end,
  })
  vim.api.nvim_create_autocmd("BufLeave", {
    group = save_view_group,
    callback = function() M.save() end,
  })
end

return M

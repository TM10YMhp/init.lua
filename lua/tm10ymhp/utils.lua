local M = {}

function M.is_large_file(filepath)
  if
    -- vim.fn.strwidth(filepath) > 300 or
    -- vim.fn.getfsize(filepath) > 1024 * 1024
    -- vim.fn.getfsize(filepath) > 512 * 1024
    vim.fn.getfsize(filepath) > 900000
  then
    return true
  else
    return false
  end
end

function M.notify(msg, log_level, opts)
  local default_opts = { title = "TM10YMhp" }
  vim.notify(
    msg,
    log_level,
    vim.tbl_extend("force", default_opts, opts or {})
  )
end

return M

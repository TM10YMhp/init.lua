local M = {}

function M.is_http()
  if vim.bo.filetype ~= 'http' then
    M.error(table.concat({
      'RestNvim is only available for filetype "http"',
      'current filetype: "' .. vim.bo.filetype .. '")',
    }, "\n"))
    return false
  end
  return true
end

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

function M.notify(msg, level, opts)
  local default_opts = { title = "Notification" }
  vim.notify(
    msg,
    level or vim.log.levels.INFO,
    vim.tbl_extend("force", default_opts, opts or {})
  )
end

function M.error(msg, opts)
  M.notify(msg, vim.log.levels.ERROR, opts or {})
end

function M.info(msg, opts)
  M.notify(msg, vim.log.levels.INFO, opts or {})
end

function M.warn(msg, opts)
  M.notify(msg, vim.log.levels.WARN, opts or {})
end

return M

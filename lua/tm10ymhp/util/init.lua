local M = {}

_G.SereneNvim = M

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("tm10ymhp.util." .. k)
    return t[k]
  end,
})

function M.notify(msg, level, opts)
  local default_opts = { title = "Notification" }

  vim.schedule(function()
    vim.notify(
      msg,
      level or vim.log.levels.INFO,
      vim.tbl_extend("force", default_opts, opts or {})
    )
  end)
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

function M.is_large_file(path)
  if
    -- vim.fn.strwidth(path) > 300 or
    -- vim.fn.getfsize(path) > 1024 * 1024 -- 1024kb
    -- vim.fn.getfsize(path) > 512 * 1024 -- 512kb
    vim.fn.getfsize(path) > 896 * 1024 -- 896kb
  then
    return true
  else
    return false
  end
end

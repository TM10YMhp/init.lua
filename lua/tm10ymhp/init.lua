local M = {}

_G.SereneNvim = M

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("tm10ymhp.util." .. k)
    return t[k]
  end,
})

M.notify = function(msg, level, opts)
  local default_opts = { title = "Notification" }

  vim.schedule(function()
    vim.notify(
      msg,
      level or vim.log.levels.INFO,
      vim.tbl_extend("force", default_opts, opts or {})
    )
  end)
end

M.error = function(msg, opts)
  M.notify(msg, vim.log.levels.ERROR, opts or {})
end

M.info = function(msg, opts)
  M.notify(msg, vim.log.levels.INFO, opts or {})
end

M.warn = function(msg, opts)
  M.notify(msg, vim.log.levels.WARN, opts or {})
end

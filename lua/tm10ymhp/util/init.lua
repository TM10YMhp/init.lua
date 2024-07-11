local M = {}

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
    -- vim.fn.getfsize(path) > 1024 * 1024 -- 1024kb
    -- vim.fn.getfsize(path) > 512 * 1024 -- 512kb
    -- vim.fn.getfsize(path) > 896 * 1024 -- 896kb
    vim.fn.getfsize(path) >= 1024 * 1024 * SereneNvim.config.bigfile_size
  then
    return true
  else
    return false
  end
end

---@param plugin string
function M.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

---@param plugin string
function M.has(plugin)
  return M.get_plugin(plugin) ~= nil
end

function M.is_loaded(name)
  local Config = require("lazy.core.config")
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  if M.is_loaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return M

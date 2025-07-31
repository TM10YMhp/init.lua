-- TODO: check this

---@class serenenvim.util
---@field cmp serenenvim.util.cmp
---@field hacks serenenvim.util.hacks
---@field heirline serenenvim.util.heirline
---@field lint serenenvim.util.lint
---@field lsp serenenvim.util.lsp
---@field lualine serenenvim.util.lualine
---@field snacks serenenvim.util.snacks
---@field telescope serenenvim.util.telescope
---_@field toggle serenenvim.util.toggle
local M = {}

setmetatable(M, {
  __index = function(t, k)
    t[k] = require("util." .. k)
    return t[k]
  end,
})

M.__IS_WINDOWS = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

function M.notify(msg, level, opts)
  local default_opts = { title = "Notification" }

  vim.schedule(
    function()
      vim.notify(
        msg,
        level or vim.log.levels.INFO,
        vim.tbl_extend("force", default_opts, opts or {})
      )
    end
  )
end

function M.error(msg, opts) M.notify(msg, vim.log.levels.ERROR, opts or {}) end

function M.info(msg, opts) M.notify(msg, vim.log.levels.INFO, opts or {}) end

function M.warn(msg, opts) M.notify(msg, vim.log.levels.WARN, opts or {}) end

---@param name string
function M.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

---@param plugin string
function M.has(plugin) return M.get_plugin(plugin) ~= nil end

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

---@param name string
function M.opts(name)
  local plugin = M.get_plugin(name)
  if not plugin then return {} end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

M.lazy_init = vim.fn.argc(-1) == 0
---@param fn fun()
function M.on_lazy_init(fn)
  if not M.lazy_init then fn() end

  vim.api.nvim_create_autocmd("User", {
    once = true,
    pattern = "VeryLazy",
    callback = function()
      if M.lazy_init then fn() end
    end,
  })
end

---@param name string
---@param pattern string|string[]
function M.on_lazy_ft(name, pattern)
  M.on_lazy_init(function()
    vim.api.nvim_create_autocmd("FileType", {
      once = true,
      pattern = pattern,
      callback = function()
        vim.defer_fn(
          function() require("lazy").load({ plugins = { name } }) end,
          10
        )
      end,
    })
  end)
end

---@param extra string
function M.has_extra(extra)
  -- local Config = require("lazyvim.config")
  local modname = "plugins.extras." .. extra
  return vim.tbl_contains(require("lazy.core.config").spec.modules, modname)
  -- or vim.tbl_contains(Config.json.data.extras, modname)
end

---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function() fn() end,
  })
end

---@param fn fun()
function M.on_init(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    callback = function() fn() end,
  })
end

---@param fn fun()
function M.bufdo(fn)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.fn.buflisted(bufnr) == 1 then
      fn(bufnr)
    end
  end
end

function M.get_module_dir(module_name)
  return vim.fs.joinpath(vim.fn.stdpath("config"), "/lua/modules", module_name)
end

return M

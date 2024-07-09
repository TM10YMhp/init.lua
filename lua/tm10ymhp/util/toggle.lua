local M = {}

---@class SereneNvim.call.Opts
---@field format string
---@field type
---| "opt_local"
---| "opt"
---| "o"
---| "buffer"
---| "b"
---| "global"
---| "g"
---@field reverse boolean

---@param option string
---@param opts? SereneNvim.call.Opts
function M.__call(option, opts)
  local defaults = {
    format = "%s " .. option,
    type = "opt",
    reverse = false,
  }
  opts = vim.tbl_deep_extend("force", defaults, opts or {})

  local type_names = {
    ["opt"] = vim.opt,
    ["opt_local"] = vim.opt_local,
    ["buffer"] = vim.b,
    ["b"] = vim.b,
    ["global"] = vim.g,
    ["g"] = vim.g,
  }
  local t = type_names[opts.type]
  if not t then
    error(string.format("invalid type name: %s", opts.type), 2)
  end

  -- http://lua-users.org/wiki/TernaryOperator
  local state
  if opts.type == "opt" or opts.type == "opt_local" then
    t[option] = not t[option]:get()
    state = (opts.reverse and { not t[option]:get() } or { t[option]:get() })[1]
  else
    t[option] = not t[option]
    state = (opts.reverse and { not t[option] } or { t[option] })[1]
  end

  local notify = state and SereneNvim.info or SereneNvim.warn
  local msg = string.format(opts.format, state and "Enabled" or "Disabled")

  notify(msg, { title = "Option" })
end

---@type {k:string, v:any}[]
M._maximized = nil
---@param state boolean?
function M.maximize(state)
  if state == (M._maximized ~= nil) then
    return
  end
  if M._maximized then
    for _, opt in ipairs(M._maximized) do
      vim.o[opt.k] = opt.v
    end
    M._maximized = nil
    vim.cmd("wincmd =")
  else
    M._maximized = {}
    local function set(k, v)
      table.insert(M._maximized, 1, { k = k, v = vim.o[k] })
      vim.o[k] = v
    end
    set("winwidth", 999)
    set("winheight", 999)
    set("winminwidth", 10)
    set("winminheight", 4)
    vim.cmd("wincmd =")
  end
  -- `QuitPre` seems to be executed even if we quit a normal window, so we don't want that
  -- `VimLeavePre` might be another consideration? Not sure about differences between the 2
  vim.api.nvim_create_autocmd("ExitPre", {
    once = true,
    group = vim.api.nvim_create_augroup(
      "tm10ymhp_restore_max_exit_pre",
      { clear = true }
    ),
    desc = "Restore width/height when close Neovim while maximized",
    callback = function()
      M.maximize(false)
    end,
  })
end

setmetatable(M, {
  __call = function(m, ...)
    return m.__call(...)
  end,
})

return M

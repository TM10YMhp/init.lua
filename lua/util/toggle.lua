-- TODO: WIP

---@class serenenvim.util.toggle
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
  if not t then error(string.format("invalid type name: %s", opts.type), 2) end

  -- http://lua-users.org/wiki/TernaryOperator
  local state
  if opts.type == "opt" or opts.type == "opt_local" then
    t[option] = not t[option]:get()
    state = (opts.reverse and { not t[option]:get() } or { t[option]:get() })[1]
  else
    t[option] = not t[option]
    state = (opts.reverse and { not t[option] } or { t[option] })[1]
  end

  local msg = string.format(opts.format, state and "Enabled" or "Disabled")
  local n = state and SereneNvim.info or SereneNvim.warn
  n(msg, { title = "Option" })
end

local _toggles = {}

---@class SereneNvim.toggle.Opts
---@field name string
---@field enable fun()
---@field disable fun()
---@field state boolean

---@param opts? SereneNvim.toggle.Opts
function M.toggle(opts)
  if not _toggles[opts.name] then _toggles[opts.name] = opts end
  local toggle = _toggles[opts.name]

  toggle.state = not toggle.state
  local cmd = toggle.state and toggle.enable or toggle.disable

  if cmd then
    cmd()
  else
    SereneNvim.warn("No command to toggle")
  end
end

-- SereneNvim.toggle({
--   enable = function() print("enabled") end,
--   disable = function() print("disabled") end,
--   state = false,
--   name = "",
-- })

setmetatable(M, {
  -- __call = function(m, ...) return m.__call(...) end,
  __call = function(m, ...) return m.toggle(...) end,
})

return M

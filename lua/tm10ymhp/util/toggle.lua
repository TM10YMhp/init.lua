local M = {}

---@class SereneNvim.call.Opts
---@field name string
---@field type
---| "opt_local"
---| "opt"
---| "o"
---| "buffer"
---| "b"
---| "global"
---| "g"

---@param option string
---@param opts? SereneNvim.call.Opts
function M.test(option, opts)
  opts = opts or { type = "opt" }

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

  local name = opts.name or option

  if opts.type == "opt" or opts.type == "opt_local" then
    t[option] = not t[option]:get()

    if t[option]:get() then
      SereneNvim.info("Enabled " .. name, { title = "Option" })
    else
      SereneNvim.warn("Disabled " .. name, { title = "Option" })
    end
  else
    t[option] = not t[option]

    if t[option] then
      SereneNvim.info("Enabled " .. name, { title = "Option" })
    else
      SereneNvim.warn("Disabled " .. name, { title = "Option" })
    end
  end
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.option(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      ---@diagnostic disable-next-line: no-unknown
      vim.opt_local[option] = values[2]
    else
      ---@diagnostic disable-next-line: no-unknown
      vim.opt_local[option] = values[1]
    end
    return SereneNvim.info(
      "Set " .. option .. " to " .. vim.opt_local[option]:get(),
      { title = "Option" }
    )
  end
  ---@diagnostic disable-next-line: no-unknown
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      SereneNvim.info("Enabled " .. option, { title = "Option" })
    else
      SereneNvim.warn("Disabled " .. option, { title = "Option" })
    end
  end
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
    return m.option(...)
  end,
})

return M

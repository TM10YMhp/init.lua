---@param t table
---@param key string|string[]
---@return any
local function key_get(t, key)
  local path = type(key) == "table" and key
    or vim.split(key, ".", { plain = true })
  local value = t
  for _, k in ipairs(path) do
    if type(value) ~= "table" then
      return value
    end
    value = value[k]
  end
  return value
end

---@param t table
---@param key string|string[]
---@param value any
local function key_set(t, key, value)
  local path = type(key) == "table" and key or vim.split(key, ".", true)
  local last = t
  for i = 1, #path - 1 do
    local k = path[i]
    if type(last[k]) ~= "table" then
      last[k] = {}
    end
    last = last[k]
  end
  last[path[#path]] = value
end

-- https://github.com/folke/lazy.nvim/blob/main/lua/lazy/core/plugin.lua#L443

local default = {
  a = {
    x = 1,
    y = 2,
    z = 3,
  },
  b = {
    q = 4,
    w = 5,
    e = 6,
  },
}

local opts = {
  b = {
    -- w = 10,
    q = 99,
  },
}

local a = key_get(default, "a.x")
key_set(default, "b.w", a + 1)
local final = vim.tbl_deep_extend("force", default, opts)
vim.print(final)

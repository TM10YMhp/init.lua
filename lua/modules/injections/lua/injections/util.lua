local M = {}

-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/__files.lua#L22
M.escape = function(s)
  return s:gsub("[\r\n\\]", {
    ["\r"] = "\\r",
    ["\n"] = "\\n",
    ["\\"] = "\\\\",
  })
end

---@param t table
---@param key string
---@return any
M.key_get = function(t, key)
  local path = vim.split(key, ".", { plain = true })
  local value = t
  for _, k in ipairs(path) do
    if type(value) ~= "table" then return value end
    value = value[k]
  end
  return value
end

---@param t table
---@param key string
---@param value any
---@return any
M.key_set = function(t, key, value)
  local keys = vim.split(key, ".", { plain = true })
  local tbl = vim.deepcopy(t)
  local cursor = tbl
  for i, k in ipairs(keys) do
    if i == #keys then
      cursor[k] = value
    else
      cursor[k] = cursor[k] or {}
      cursor = cursor[k]
    end
  end
  return tbl
end

---@param v {extend: string[]}
---@param template table
---@return {[string]: any}
M.extended = function(v, template)
  local inherit = v.extend
  if type(inherit) ~= "table" then return v end

  v.extend = nil
  local value = vim.deepcopy(v)

  local res = {}
  for _, extend in ipairs(inherit) do
    local val = M.key_get(template, extend)
    local key, num = extend:gsub("^[^.]+%.", "")
    if num == 0 then
      res = vim.tbl_deep_extend("force", template[extend], value)
    else
      local d = M.key_set({}, key, val)
      res = vim.tbl_deep_extend("force", res, d)
    end
  end
  return vim.tbl_deep_extend("force", res, value)
end

return M

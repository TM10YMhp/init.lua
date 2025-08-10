-- inpiration:
-- - "Dronakurl/injectme.nvim",
-- - "dariuscorvus/tree-sitter-language-injection.nvim",

-- UPDATE: check this
-- - https://github.com/nvimdev/template.nvim

-- HACK: relative import
package.path = "./scripts/?.lua;" .. package.path
local template = require("injections.default").template
local util = require("injections.util")

local function parse(v)
  local result = ";extends\n"
  v = util.extended(v, template)

  local keys = vim.tbl_keys(v)
  table.sort(keys)

  for _, k in ipairs(keys) do
    local key = k
    local data = v[k]
    -- for key, data in pairs(v) do
    if key then
      result = ("%s\n;; ================ %s ================\n"):format(
        result,
        key
      )
    end
    if data.query and data.vars then
      for _, var in pairs(data.vars) do
        local query = data.query

        for k, value in pairs(var) do
          local a = util.escape(value)
          query = query:gsub(("{%s}"):format(k), a)
        end

        result = result .. "\n" .. query
      end
    end
  end
  return result
end

local function write_injection(lang, content)
  local file_path = vim.fn.stdpath("config")
    .. "/after/queries"
    .. "/"
    .. lang
    .. "/injections.scm"
  local directory_path = vim.fn.fnamemodify(file_path, ":p:h")

  if vim.fn.isdirectory(directory_path) == 0 then
    vim.fn.mkdir(directory_path, "p")
  end

  local file = io.open(file_path, "w")
  vim.print(file_path)
  if file then
    file:write(content)
    file:close()
  else
    print("Error: Cannot open file " .. file_path)
  end
end

local M = {}

M.run = function()
  for lang, v in pairs(template) do
    local result = parse(v)
    write_injection(lang, result)
  end
end

return M

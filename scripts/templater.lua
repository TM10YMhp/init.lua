local M = {}

---@type { [string]: string|fun(capture: string): string }
M.expressions = {}

---@param expr string
---@param replacer string|fun(capture: string): string
---@param force boolean?
M.register = function(expr, replacer, force)
  if not (force == true) and M.expressions[expr] then
    vim.notify("The expression `" .. expr .. "` is already registered.")
    return
  end

  M.expressions[expr] = replacer
end

M.register_builtins = function()
  M.register(
    "{{_date_}}",
    function() return tostring(os.date("%Y-%m-%d %H:%M:%S")) end
  )
  M.register("{{_file_name_}}", function() return vim.fn.expand("%:t:r") end)
  M.register(
    "{{_variable_}}",
    function() return vim.fn.input("Variable name: ", "") end
  )
  M.register(
    "{{_upper_file_}}",
    function() return string.upper(vim.fn.expand("%:t:r")) end
  )

  M.register(
    "{{_lua:(.-)_}}",
    function(capture) return load("return " .. capture)() end
  )
end

---@param _line string
---@return string
M.render_line = function(_line)
  local line = _line
  for expr, render in pairs(M.expressions) do
    if not line:find(expr) then goto continue end

    while true do
      local matched = line:match(expr)
      if not matched then break end

      local replacement = type(render) == "string" and render or render(matched)
      line = line:gsub(expr, replacement)
    end

    ::continue::
  end
  return line
end

---@param _lines string
---@return string
M.render = function(_lines)
  local lines = _lines
  for expr, render in pairs(M.expressions) do
    if not lines:find(expr) then goto continue end

    while true do
      local matched = lines:match(expr)
      if not matched then break end

      local replacement = type(render) == "string" and render or render(matched)
      lines = lines:gsub(expr, replacement)
    end

    ::continue::
  end
  return lines
end

-- local query = [=[
-- ;; comment {name} injection
-- (chunk
--   (comment) @comment
--     local_declaration: (variable_declaration
--       (assignment_statement
--         (expression_list
--           value: (string
--             content: (string_content) @injection.content))
--   (#match? @comment "{match}")
--   (#set! injection.language "{name}"))))
-- ]=]
-- -- local res = query:gsub("{match}", "WAZA")
--
-- M.register("{match}", "11111")
-- M.register("{name}", "22222")
-- vim.print(M.render(query))
--
-- M.register("{match}", "AAAAA")
-- M.register("{name}", "BBBBB")
-- vim.print(M.render(query))

return M

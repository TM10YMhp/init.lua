-- inpiration:
-- - "Dronakurl/injectme.nvim",
-- - "dariuscorvus/tree-sitter-language-injection.nvim",

-- UPDATE: check this
-- - https://github.com/nvimdev/template.nvim

-- query
local javascript_string_query = [=[
;; string {name} injection
((string_fragment) @injection.content
  (#match? @injection.content "{match}")
  (#set! injection.language "{name}"))
]=]

-- query
local javascript_comment_query = [=[
;; comment {name} injection
((comment) @comment .
  (lexical_declaration
    (variable_declarator
      value: [
        (string (string_fragment) @injection.content)
        (template_string (string_fragment) @injection.content)
      ] @injection.content)
    )
  (#match? @comment "{match}")
  (#set! injection.language "{name}"))
]=]

-- query
local python_comment_query = [=[
;; comment {name} injection
((comment) @comment .
  (expression_statement
    (assignment right:
      (string (string_content) @injection.content
      (#match? @comment "{match}")
      (#set! injection.language "{name}")))))
]=]

-- query
local python_string_query = [=[
;; string {name} injection
((string_content) @injection.content
  (#match? @injection.content "{match}")
  (#set! injection.language "{name}"))
]=]

-- query
local rust_string_query = [=[
;; string {name} injection
((string_content) @injection.content
  (#match? @injection.content "{match}")
  (#set! injection.language "{name}"))
]=]

-- query
local rust_comment_query = [=[
;; comment {name} injection
((line_comment) @comment .
  (let_declaration
    value:
      (raw_string_literal (string_content) @injection.content))
  (#match? @comment "{match}")
  (#set! injection.language "{name}"))
]=]

-- query
local javascript_block_comment_query = [=[
;; variable {name} injection
(variable_declarator
  (comment) @_comment
  value:
    (template_string (string_fragment) @injection.content)
  (#match? @_comment "{match}")
  (#set! injection.language "{name}"))

;; argument {name} injection
(call_expression
  arguments: (arguments
    (comment) @_comment
    (template_string (string_fragment) @injection.content))
  (#match? @_comment "{match}")
  (#set! injection.language "{name}"))
]=]

-- query
local lua_comment_query = [=[
;; comment {name} injection
(chunk
  (comment) @comment
    local_declaration: (variable_declaration
      (assignment_statement
        (expression_list
          value: (string
            content: (string_content) @injection.content))
  (#match? @comment "{match}")
  (#set! injection.language "{name}"))))
]=]

-- query
local html_alpine_query = [=[
;; alpine {name} injection
((element
  (start_tag
    (attribute
      (attribute_name) @_name
      (quoted_attribute_value (attribute_value) @injection.content))))
  (#match? @_name "{match}")
  (#set! injection.language "{name}"))
]=]

local template = {
  javascript = {
    string = {
      vars = {
        { name = "sql", match = "^(\r\n|\r|\n)*--+( )*sql" },
        { name = "javascript", match = "^(\r\n|\r|\n)*//+( )*(javascript|js)" },
        { name = "typescript", match = "^(\r\n|\r|\n)*//+( )*(typescript|ts)" },
        { name = "html", match = "^(\r\n|\r|\n)*\\<\\!--( )*html( )*--\\>" },
        { name = "css", match = "^(\r\n|\r|\n)*/\\*+( )*css( )*\\*+/" },
        { name = "python", match = "^(\r\n|\r|\n)*#+( )*py" },
      },
      query = javascript_string_query,
    },
    comment = {
      vars = {
        { name = "sql", match = "^//+( )*sql(\\s|$)" },
        { name = "javascript", match = "^//+( )*(javascript|js)(\\s|$)" },
        { name = "typescript", match = "^//+( )*(typescript|ts)(\\s|$)" },
        { name = "html", match = "^//+( )*html(\\s|$)" },
        { name = "css", match = "^//+( )*css(\\s|$)" },
        { name = "python", match = "^//+( )*(python|py)(\\s|$)" },
      },
      query = javascript_comment_query,
    },
    block_comment = {
      vars = {
        { name = "css", match = "/\\*( )*css( )*\\*/" },
        { name = "sql", match = "/\\*( )*sql( )*\\*/" },
        { name = "typescript", match = "/\\*( )*(ts|typescript)( )*\\*/" },
        { name = "javascript", match = "/\\*( )*(js|javascript)( )*\\*/" },
        { name = "html", match = "/\\*( )*html( )*\\*/" },
        { name = "python", match = "/\\*( )*(py|python)( )*\\*/" },
      },
      query = javascript_block_comment_query,
    },
  },
  typescript = {
    extend = { "javascript" },
  },
  rust = {
    extend = {
      "javascript.string",
      "javascript.comment",
    },
    string = {
      query = rust_string_query,
    },
    comment = {
      query = rust_comment_query,
    },
  },
  python = {
    extend = { "javascript.string" },
    string = {
      query = python_string_query,
    },
    comment = {
      vars = {
        { name = "sql", match = "^#+( )*sql(\\s|$)" },
        { name = "javascript", match = "^#+( )*(javascript|js)(\\s|$)" },
        { name = "typescript", match = "^#+( )*(typescript|ts)(\\s|$)" },
        { name = "html", match = "^#+( )*html(\\s|$)" },
        { name = "css", match = "^#+( )*css(\\s|$)" },
        { name = "python", match = "^#+( )*(python|py)(\\s|$)" },
      },
      query = python_comment_query,
    },
  },
  lua = {
    comment = {
      vars = {
        { name = "query", match = "^--+( )*query(\\s|$)" },
      },
      query = lua_comment_query,
    },
  },
  html = {
    alpine = {
      vars = {
        {
          name = "javascript",
          match = "x-(data|init|show|bind|on|text|html|model|modelable|for|effect|ref|teleport|if|id)",
        },
        { name = "javascript", match = "^:" },
      },
      query = html_alpine_query,
    },
  },
}

-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/__files.lua#L22
local function escape(s)
  return s:gsub("[\r\n\\]", {
    ["\r"] = "\\r",
    ["\n"] = "\\n",
    ["\\"] = "\\\\",
  })
end

---@param t table
---@param key string
---@return any
local function key_get(t, key)
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
local function key_set(t, key, value)
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
---@return {[string]: any}
local function extended(v)
  local inherit = v.extend
  if type(inherit) ~= "table" then return v end

  v.extend = nil
  local value = vim.deepcopy(v)

  local res = {}
  for _, extend in ipairs(inherit) do
    local val = key_get(template, extend)
    local key, num = extend:gsub("^[^.]+%.", "")
    if num == 0 then
      res = vim.tbl_deep_extend("force", template[extend], value)
    else
      local d = key_set({}, key, val)
      res = vim.tbl_deep_extend("force", res, d)
    end
  end
  return vim.tbl_deep_extend("force", res, value)
end

-- TODO: resolve order???
local function parse(v)
  local result = ";extends\n"
  v = extended(v)

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
          local a = escape(value)
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
  if file then
    file:write(content)
    file:close()
  else
    print("Error: Cannot open file " .. file_path)
  end
end

local function run()
  for lang, v in pairs(template) do
    local result = parse(v)
    write_injection(lang, result)
  end
end

run()

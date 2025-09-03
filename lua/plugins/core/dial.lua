---@param increment boolean
---@param g? boolean
local dial = function(increment, g)
  local mode = vim.fn.mode(true)
  -- Use visual commands for VISUAL 'v', VISUAL LINE 'V' and VISUAL BLOCK '\22'
  local is_visual = mode == "v" or mode == "V" or mode == "\22"
  local func = (increment and "inc" or "dec")
    .. (g and "_g" or "_")
    .. (is_visual and "visual" or "normal")
  local group = vim.g.dials_by_ft[vim.bo.filetype] or "default"
  return require("dial.map")[func](group)
end

return {
  "monaqa/dial.nvim",
  keys = {
    {
      "<C-a>",
      function() return dial(true) end,
      expr = true,
      desc = "Increment",
      mode = { "n", "x" },
    },
    {
      "<C-x>",
      function() return dial(false) end,
      expr = true,
      desc = "Decrement",
      mode = { "n", "x" },
    },
    {
      "g<C-a>",
      function() return dial(true, true) end,
      expr = true,
      desc = "Increment",
      mode = { "n", "x" },
    },
    {
      "g<C-x>",
      function() return dial(false, true) end,
      expr = true,
      desc = "Decrement",
      mode = { "n", "x" },
    },
  },
  opts = function()
    local augend = require("dial.augend")

    local logical_alias = augend.constant.new({
      elements = { "&&", "||" },
      word = false,
      cyclic = true,
    })

    local capitalized_boolean = augend.constant.new({
      elements = {
        "True",
        "False",
      },
      word = true,
      cyclic = true,
    })

    return {
      dials_by_ft = {
        vue = "vue",
        javascript = "typescript",
        typescript = "typescript",
        typescriptreact = "typescript",
        javascriptreact = "typescript",
        lua = "lua",
        markdown = "markdown",
        python = "python",
      },
      groups = {
        default = {
          augend.hexcolor.new({ case = "prefer_lower" }),
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.decimal_int, -- nonnegative and negative decimal number
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
          capitalized_boolean,
          augend.constant.alias.bool, -- boolean value (true <-> false)
          logical_alias,
          -- augend.constant.alias.alpha,
          -- augend.constant.alias.Alpha,
        },
        vue = {
          augend.constant.new({ elements = { "let", "const" } }),
        },
        typescript = {
          augend.constant.new({ elements = { "let", "const" } }),
        },
        markdown = {
          augend.misc.alias.markdown_header,
        },
        lua = {
          augend.constant.new({
            elements = { "and", "or" },
            word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
            cyclic = true, -- "or" is incremented into "and".
          }),
          -- augend.constant.new({
          --   elements = { "<", "<=", ">", ">=" },
          --   pattern_regexp = [[\C\M\(%s\)=\@!]],
          -- }),
        },
        python = {
          augend.constant.new({
            elements = { "and", "or" },
          }),
        },
      },
    }
  end,
  config = function(_, opts)
    -- copy defaults to each group
    for name, group in pairs(opts.groups) do
      if name ~= "default" then vim.list_extend(group, opts.groups.default) end
    end
    require("dial.config").augends:register_group(opts.groups)
    vim.g.dials_by_ft = opts.dials_by_ft
  end,
}

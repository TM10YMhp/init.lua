-- TODO: custom_textobjects nvim_various_textobjs
return {
  "echasnovski/mini.ai",
  keys = function()
    local i = {
      [" "] = "Whitespace",
      ['"'] = 'Balanced "',
      ["'"] = "Balanced '",
      ["`"] = "Balanced `",
      ["("] = "Balanced (",
      [")"] = "Balanced ) including white-space",
      [">"] = "Balanced > including white-space",
      ["<"] = "Balanced <",
      ["]"] = "Balanced ] including white-space",
      ["["] = "Balanced [",
      ["}"] = "Balanced } including white-space",
      ["{"] = "Balanced {",
      ["?"] = "User Prompt",
      _ = "Underscore",
      a = "Argument",
      b = "Balanced ), ], }",
      d = "Digit(s)",
      -- e = "Word in CamelCase & snake_case",
      f = "Function",
      q = "Quote `, \", '",
      t = "Tag",
      n = "Next",
      l = "Last",
      u = "URL",
      g = "Entire Buffer",
      e = "Word in CamelCase & snake_case",
      -- k = "Key",
    }

    local a = vim.deepcopy(i)
    for k, v in pairs(a) do
      a[k] = v:gsub(" including.*", "")
    end

    local mappings = {
      { "g[", mode = { "n", "x", "o" }, desc = 'Move to left "around"' },
      { "g]", mode = { "n", "x", "o" }, desc = 'Move to right "around"' },
    }

    for key, name in pairs(i) do
      table.insert(
        mappings,
        { "i" .. key, mode = { "x", "o" }, desc = "Inside " .. name }
      )
    end
    for key, name in pairs(a) do
      table.insert(
        mappings,
        { "a" .. key, mode = { "x", "o" }, desc = "Around " .. name }
      )
    end

    return mappings
  end,
  opts = function()
    local spec_treesitter = require("mini.ai").gen_spec.treesitter

    return {
      mappings = {
        -- Main textobject prefixes
        around = "a",
        inside = "i",

        -- Next/last textobjects
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",

        -- Move cursor to corresponding edge of `a` textobject
        goto_left = "g[",
        goto_right = "g]",
      },
      n_lines = 500,
      custom_textobjects = {
        -- Need 'nvim-treesitter/nvim-treesitter-textobjects'
        o = spec_treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
        C = spec_treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        d = function(scope)
          -- NOTE: http://lua-users.org/wiki/FrontierPattern
          local pattern = scope == "i" and { "%d+" } or { "%-?%d*%.?%d+" }
          return pattern
        end,
        u = { "%l%l%l-://[A-Za-z0-9_%-/.#%%=?&'@+]+" },
        g = function() -- Whole buffer, similar to `gg` and 'G' motion
          local from = { line = 1, col = 1 }
          local to = {
            line = vim.fn.line("$"),
            col = math.max(vim.fn.getline("$"):len(), 1),
          }
          return { from = from, to = to }
        end,
        e = { -- Word with case
          {
            "%u[%l%d]+%f[^%l%d]",
            "%f[%S][%l%d]+%f[^%l%d]",
            "%f[%P][%l%d]+%f[^%l%d]",
            "^[%l%d]+%f[^%l%d]",
          },
          "^().*()$",
        },
        -- TODO: WIP
        -- k = { "%f[%S]%S.- ?[:=] ?", "^().*()$" },
        -- k = function(scope)
        --   local pattern = scope == "i" and { "%f[%S]%S*[:=]?", "^().*()$" }
        --     or { "%f[%S]%S.- ?[:=] ?", "^().*()$" }
        --   return pattern
        -- end,
      },
    }
  end,
}

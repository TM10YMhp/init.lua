-- TODO: which key
-- local i = {
--   [" "] = "Whitespace",
--   ['"'] = 'Balanced "',
--   ["'"] = "Balanced '",
--   ["`"] = "Balanced `",
--   ["("] = "Balanced (",
--   [")"] = "Balanced ) including white-space",
--   [">"] = "Balanced > including white-space",
--   ["<"] = "Balanced <",
--   ["]"] = "Balanced ] including white-space",
--   ["["] = "Balanced [",
--   ["}"] = "Balanced } including white-space",
--   ["{"] = "Balanced {",
--   ["?"] = "User Prompt",
--   _ = "Underscore",
--   a = "Argument",
--   b = "Balanced ), ], }",
--   d = "Digit(s)",
--   f = "Function",
--   q = "Quote `, \", '",
--   t = "Tag",
--   n = "Next",
--   l = "Last",
--   u = "URL",
--   e = "Word in CamelCase & snake_case",
-- }
--
-- local a = vim.deepcopy(i)
-- for k, v in pairs(a) do
--   a[k] = v:gsub(" including.*", "")
-- end

-- TODO: custom_textobjects nvim_various_textobjs
return {
  "echasnovski/mini.ai",
  keys = {
    { "a", mode = { "x", "o" }, desc = "Around textobject" },
    { "i", mode = { "x", "o" }, desc = "Inside textobject" },
    { "g[", mode = { "n", "x", "o" }, desc = 'Move to left "around"' },
    { "g]", mode = { "n", "x", "o" }, desc = 'Move to right "around"' },
  },
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
        e = { -- Word with case
          {
            "%u[%l%d]+%f[^%l%d]",
            "%f[%S][%l%d]+%f[^%l%d]",
            "%f[%P][%l%d]+%f[^%l%d]",
            "^[%l%d]+%f[^%l%d]",
          },
          "^().*()$",
        },
        u = { "%l%l%l-://[A-Za-z0-9_%-/.#%%=?&'@+]+" },
        k = function(scope)
          local res = {}
          for i = 1, vim.api.nvim_buf_line_count(0) do
            local cur_line = vim.fn.getline(i)
            local _, _, G1, G2, _, G4 = cur_line:find("()%S.-()( ?[:=] ?)()")

            if G1 and G2 then
              local region = {
                from = { line = i, col = G1 },
                to = {
                  line = i,
                  col = (scope == "a" and G4) and G4 - 1 or G2 - 1,
                },
              }
              table.insert(res, region)
            end
          end
          return res
        end,
      },
    }
  end,
}

return {
  {
    "echasnovski/mini.ai",
    dependencies = { "echasnovski/mini.extra" },
    event = "VeryLazy",
    opts = function()
      local spec_treesitter = require("mini.ai").gen_spec.treesitter
      local gen_ai_spec = require("mini.extra").gen_ai_spec

      return {
        n_lines = 500,
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
        custom_textobjects = {
          u = {
            -- "%l%l%l-://[A-Za-z0-9_%-/.#%%=?&'@+*:]+",

            -- [[%s%l%l%l+://[^%s)%]}"'`>]+]],
            -- "^.().*()$",

            [[%f[%l]%l%l+://[^%s)%]}"'`>]+]],
          },
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          e = { -- Word with case
            {
              "%u[%l%d]+%f[^%l%d]",
              "%f[%S][%a%d]+%f[^%a%d]",
              "%f[%P][%a%d]+%f[^%a%d]",
              "^[%l%d]+%f[^%l%d]",
            },
            "^().*()$",
          },
          -- Need 'nvim-treesitter/nvim-treesitter-textobjects'
          o = spec_treesitter({
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
          -- Need 'mini.extra'
          g = gen_ai_spec.buffer(),
          d = gen_ai_spec.number(),
        },
      }
    end,
  },
  {
    "nvim-treesitter",
    optional = true,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = {},
  },
}

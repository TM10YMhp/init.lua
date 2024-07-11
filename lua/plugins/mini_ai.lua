-- TODO: custom_textobjects nvim_various_textobjs
return {
  "echasnovski/mini.ai",
  dependencies = { "echasnovski/mini.extra", config = true },
  keys = {
    { "a", mode = { "x", "o" }, desc = "Around textobject" },
    { "i", mode = { "x", "o" }, desc = "Inside textobject" },
    { "g[", mode = { "n", "x", "o" }, desc = 'Move to left "around"' },
    { "g]", mode = { "n", "x", "o" }, desc = 'Move to right "around"' },
  },
  opts = function()
    local spec_treesitter = require("mini.ai").gen_spec.treesitter
    local gen_ai_spec = require("mini.extra").gen_ai_spec

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
        g = gen_ai_spec.buffer(),
        n = gen_ai_spec.number(),
        -- Need 'nvim-treesitter/nvim-treesitter-textobjects'
        o = spec_treesitter({
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
        C = spec_treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        e = { -- Word with case
          {
            "%f[%S][%u%d]+%f[^%u%d]",
            "%f[%P][%u%d]+%f[^%u%d]",

            "%u[%l%d]+%f[^%l%d]",
            "%f[%S][%l%d]+%f[^%l%d]",
            "%f[%P][%l%d]+%f[^%l%d]",
            "^[%l%d]+%f[^%l%d]",
          },
          "^().*()$",
        },
        u = { "%l%l%l-://[A-Za-z0-9_%-/.#%%=?&'@+*]+" },
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
        v = function(scope)
          local res = {}
          for i = 1, vim.api.nvim_buf_line_count(0) do
            local cur_line = vim.fn.getline(i)
            local _, _, G3, _, G1, G2 =
              cur_line:find("()(%s*%f[!<>~=:][=:]%s*)()[^=:].*()")

            if G1 and G2 then
              local valueEndCol = (scope == "i" and cur_line:find("[,;]$"))
                  and G2 - 2
                or G2 - 1
              local region = {
                from = {
                  line = i,
                  col = (scope == "a" and G3) and G3 or G1,
                },
                to = {
                  line = i,
                  col = valueEndCol,
                },
              }
              table.insert(res, region)
            end
          end
          return res
        end,
        x = function(scope)
          local res = {}
          for i = 1, vim.api.nvim_buf_line_count(0) do
            local cur_line = vim.fn.getline(i)
            local beginCol = 0
            local endCol = 0

            repeat
              beginCol, endCol, _, G1, G2 =
                cur_line:find([[(%w+=["'{])().-()(["'}])]], endCol)

              if beginCol and endCol then
                if scope == "i" then
                  beginCol = G1
                  endCol = G2 - 1
                end

                local region = {
                  from = {
                    line = i,
                    col = beginCol,
                  },
                  to = {
                    line = i,
                    col = endCol,
                  },
                }
                table.insert(res, region)
              end
            until (endCol and (cur_line:len() < endCol)) or not beginCol
          end
          return res
        end,
      },
    }
  end,
}

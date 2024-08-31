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
        -- mini.extra
        g = function(ai_type)
          local start_line, end_line = 1, vim.fn.line("$")
          if ai_type == "i" then
            -- Skip first and last blank lines for `i` textobject
            local first_nonblank, last_nonblank =
              vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
            -- Do nothing for buffer with all blanks
            if first_nonblank == 0 or last_nonblank == 0 then
              return { from = { line = start_line, col = 1 } }
            end
            start_line, end_line = first_nonblank, last_nonblank
          end

          local to_col = math.max(vim.fn.getline(end_line):len(), 1)
          return {
            from = { line = start_line, col = 1 },
            to = { line = end_line, col = to_col },
          }
        end,
        d = function(ai_type)
          local digits_pattern = "%f[%d]%d+%f[%D]"

          local find_a_number = function(line, init)
            -- First find consecutive digits
            local from, to = line:find(digits_pattern, init)
            if from == nil then
              return nil, nil
            end

            -- Make sure that these digits were not processed before. This can happen
            -- because 'miin.ai' does next with `init = from + 1`, meaning that
            -- "-12.34" was already matched, then it would try to match starting from
            -- "1": we want to avoid matching that right away and avoid matching "34"
            -- from this number.
            if from == init and line:sub(from - 1, from - 1) == "-" then
              init = to + 1
              from, to = line:find(digits_pattern, init)
            end
            if from == nil then
              return nil, nil
            end

            if line:sub(from - 2):find("^%d%.") ~= nil then
              init = to + 1
              from, to = line:find(digits_pattern, init)
            end
            if from == nil then
              return nil, nil
            end

            -- Match the whole number with minus and decimal part
            if line:sub(from - 1, from - 1) == "-" then
              from = from - 1
            end
            local dec_part = line:sub(to + 1):match("^%.%d+()")
            if dec_part ~= nil then
              to = to + dec_part - 1
            end
            return from, to
          end

          if ai_type == "i" then
            return { digits_pattern }
          end

          return { find_a_number, { "^().*()$" } }
        end,
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
        u = { "%l%l%l-://[A-Za-z0-9_%-/.#%%=?&'@+*:]+" },
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

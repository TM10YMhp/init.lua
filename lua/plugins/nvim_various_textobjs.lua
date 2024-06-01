return {
  "chrisgrieser/nvim-various-textobjs",
  keys = function()
    local mappings = {
      {
        "ii",
        "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
        mode = { "o", "x" },
        desc = "Indentation",
      },
      {
        "iI",
        "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
        mode = { "o", "x" },
        desc = "Indentation",
      },
      {
        "ai",
        "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>",
        mode = { "o", "x" },
        desc = "Indentation",
      },
      {
        "aI",
        "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>",
        mode = { "o", "x" },
        desc = "Indentation",
      },
    }

    local innerOuterMaps = {
      -- number = "d",
      -- value = "V",
      -- key = "K",
      -- subword = "e", -- lowercase taken for sentence textobj
      closedFold = "z", -- z is the common prefix for folds
      chainMember = "m",
      -- htmlAttribute = "X",
      doubleSquareBrackets = "D",
      mdlink = "L",
      mdFencedCodeBlock = "M",
      mdEmphasis = "E",
      pyTripleQuotes = "y",
    }
    for objName, map in pairs(innerOuterMaps) do
      table.insert(mappings, {
        "i" .. map,
        "<cmd>lua require('various-textobjs')." .. objName .. "('inner')<CR>",
        mode = { "o", "x" },
        desc = "inner " .. objName,
      })

      table.insert(mappings, {
        "a" .. map,
        "<cmd>lua require('various-textobjs')." .. objName .. "('outer')<CR>",
        mode = { "o", "x" },
        desc = "outer " .. objName,
      })
    end

    -- NOTE: keep
    local oneMaps = {
      visibleInWindow = "gw",
      restOfIndentation = "R",
      restOfWindow = "gW",
      column = "|",
      entireBuffer = "gG", -- G + gg
      -- url = "gl",
    }
    for objName, map in pairs(oneMaps) do
      table.insert(mappings, {
        map,
        "<cmd>lua require('various-textobjs')." .. objName .. "()<CR>",
        mode = { "o", "x" },
        desc = objName,
      })
    end

    return mappings
  end,
}

return {
  "chrisgrieser/nvim-various-textobjs",
  keys = function()
    local mappings = {
      {
        "ii",
        "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
        mode = { "o", "x" },
        desc = "inner-inner indentation textobj"
      },
      {
        "ai" ,
        "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>",
        mode = { "o", "x" },
        desc = "outer-inner indentation textobj"
      },
      {
        "iI" ,
        "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
        mode = { "o", "x" },
        desc = "inner-inner indentation textobj"
      },
      {
        "aI" ,
        "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>",
        mode = { "o", "x" },
        desc = "outer-outer indentation textobj"
      },
    }

    local innerOuterMaps = {
      number = "n",
      value = "v",
      key = "k",
      subword = "S", -- lowercase taken for sentence textobj
      closedFold = "z", -- z is the common prefix for folds
      chainMember = "m",
      htmlAttribute = "x",
      doubleSquareBrackets = "D",
      mdlink = "l",
      mdFencedCodeBlock = "C",
      mdEmphasis = "e",
      pyTripleQuotes = "y",
    }

    for objName, map in pairs(innerOuterMaps) do
      local name = " " .. objName .. " textobj"
      table.insert(mappings, {
        "a" .. map,
        "<cmd>lua require('various-textobjs')." .. objName .. "('outer')<CR>",
        mode = { "o", "x" },
        desc = "outer" .. name
      })

      table.insert(mappings, {
        "i" .. map,
        "<cmd>lua require('various-textobjs')." .. objName .. "('inner')<CR>",
        mode = { "o", "x" },
        desc = "inner" .. name
      })
    end

    local oneMaps = {
      visibleInWindow = "gw",
      restOfIndentation = "R",
      restOfParagraph = "r",
      restOfWindow = "gW",
      column = "|",
      entireBuffer = "gG", -- G + gg
      url = "iu",
      multiCommentedLines = "ic"
    }

    for objName, map in pairs(oneMaps) do
      table.insert(mappings, {
        map,
        "<cmd>lua require('various-textobjs')." .. objName .. "()<CR>",
        mode = { "o", "x" },
        desc = objName .. " textobj"
      })
    end

    return mappings
  end,
}

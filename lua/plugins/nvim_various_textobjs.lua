return {
  "chrisgrieser/nvim-various-textobjs",
  event = "VeryLazy",
  config = function()
    require("various-textobjs").setup({})

    vim.keymap.set(
      { "o", "x" },
      "ii" ,
      "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
      { desc = "inner-inner indentation textobj" }
    )
    vim.keymap.set(
      { "o", "x" },
      "ai" ,
      "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>",
      { desc = "outer-inner indentation textobj" }
    )
    vim.keymap.set(
      { "o", "x" },
      "iI" ,
      "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
      { desc = "inner-inner indentation textobj" }
    )
    vim.keymap.set(
      { "o", "x" },
      "aI" ,
      "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>",
      { desc = "outer-outer indentation textobj" }
    )

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
      pyTripleQuotes = "y",
    }

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

    for objName, map in pairs(innerOuterMaps) do
      local name = " " .. objName .. " textobj"
      vim.keymap.set(
        { "o", "x" },
        "a" .. map,
        "<cmd>lua require('various-textobjs')." .. objName .. "('outer')<CR>",
        { desc = "outer" .. name }
      )
      vim.keymap.set(
        { "o", "x" },
        "i" .. map,
        "<cmd>lua require('various-textobjs')." .. objName .. "('inner')<CR>",
        { desc = "inner" .. name }
      )
    end

    for objName, map in pairs(oneMaps) do
      vim.keymap.set(
        { "o", "x" },
        map,
        "<cmd>lua require('various-textobjs')." .. objName .. "()<CR>",
        { desc = objName .. " textobj" }
      )
    end
  end
}

return {
  "chrisgrieser/nvim-various-textobjs",
  keys = {
    { "ii", mode = { "o", "x" }, desc = "Indentation" },
    { "iI", mode = { "o", "x" }, desc = "Indentation" },
    { "ai", mode = { "o", "x" }, desc = "Indentation" },
    { "aI", mode = { "o", "x" }, desc = "Indentation" },

    { "R", mode = { "o", "x" }, desc = "restOfIndentation" },
    { "gW", mode = { "o", "x" }, desc = "restOfWindow" },
    { "|", mode = { "o", "x" }, desc = "column" },
  },
  config = function()
    require("various-textobjs").setup()

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

    -- NOTE: keep
    local oneMaps = {
      -- visibleInWindow = "gw", -- break `gw` format
      restOfIndentation = "R",
      restOfWindow = "gW",
      column = "|",
      -- entireBuffer = "gG", -- G + gg
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

    for _, mapping in pairs(mappings) do
      vim.keymap.set(mapping.mode, mapping[1], mapping[2], {
        desc = mapping.desc,
      })
    end
  end,
}

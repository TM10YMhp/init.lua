return {
  "jake-stewart/multicursor.nvim",
  main = "multicursor-nvim",
  keys = {
    {
      "<leader>qa",
      function() require("multicursor-nvim").matchAllAddCursors() end,
      mode = { "x", "n" },
      desc = "Add all cursors",
    },
    {
      "<leader>qx",
      function() require("multicursor-nvim").toggleCursor() end,
      desc = "Toggle cursor",
    },
    {
      "<leader>qs",
      function() require("multicursor-nvim").enableCursors() end,
      mode = { "x", "n" },
      desc = "Enable cursors",
    },

    {
      "<leader>qn",
      function() require("multicursor-nvim").matchAddCursor(1) end,
      mode = { "x", "n" },
    },
    {
      "<leader>qp",
      function() require("multicursor-nvim").matchAddCursor(-1) end,
      mode = { "x", "n" },
    },
  },
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup({})

    -- Mappings defined in a keymap layer only apply when there are
    -- multiple cursors. This lets you have overlapping mappings.
    mc.addKeymapLayer(function(layerSet)
      layerSet({ "n" }, "<c-q>", mc.toggleCursor)

      -- Select a different cursor as the main one.
      layerSet({ "n", "x" }, "<c-p>", mc.prevCursor)
      layerSet({ "n", "x" }, "<c-n>", mc.nextCursor)

      -- Delete the main cursor.
      -- layerSet({ "n", "x" }, "<leader>qd", mc.deleteCursor)

      -- Enable and clear cursors using escape.
      layerSet("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end)
    end)
  end,
}

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>ma",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon: Add File",
    },
    {
      "<leader>mm",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon: Quick Menu",
    },
    {
      "<leader>m1",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon: Nav File 1",
    },
    {
      "<leader>m2",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon: Nav File 2",
    },
    {
      "<leader>m3",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon: Nav File 3",
    },
    {
      "<leader>m4",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon: Nav File 4",
    },
    {
      "<leader>m5",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "Harpoon: Nav File 5",
    },
  },
  opts = {
    settings = {
      save_on_toggle = true,
    },
  },
}

return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = {
      {
        "<leader>M",
        function() require("harpoon"):list():add() end,
        desc = "Harpoon: Add File",
      },
      {
        "<leader>m",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Harpoon: Quick Menu",
      },
      {
        "<leader>1",
        function() require("harpoon"):list():select(1) end,
        desc = "Harpoon: Nav File 1",
      },
      {
        "<leader>2",
        function() require("harpoon"):list():select(2) end,
        desc = "Harpoon: Nav File 2",
      },
      {
        "<leader>3",
        function() require("harpoon"):list():select(3) end,
        desc = "Harpoon: Nav File 3",
      },
      {
        "<leader>4",
        function() require("harpoon"):list():select(4) end,
        desc = "Harpoon: Nav File 4",
      },
      {
        "<leader>5",
        function() require("harpoon"):list():select(5) end,
        desc = "Harpoon: Nav File 5",
      },

      {
        "]n",
        function() require("harpoon"):list():next({ ui_nav_wrap = true }) end,
        desc = "Harpoon: Next File",
      },
      {
        "[n",
        function() require("harpoon"):list():prev({ ui_nav_wrap = true }) end,
        desc = "Harpoon: Prev File",
      },
    },
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
  },
}

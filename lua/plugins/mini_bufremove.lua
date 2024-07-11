return {
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer New",
      },
      {
        "<leader>bD",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force) New",
      },
    },
    opts = {
      set_vim_settings = false,
    },
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = {
      options = {
        close_command = function(bufnr)
          require("mini.bufremove").delete(bufnr, false)
        end,
        right_mouse_command = function(bufnr)
          require("mini.bufremove").delete(bufnr, false)
        end,
      },
    },
  },
}

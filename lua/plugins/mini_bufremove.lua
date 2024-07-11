return {
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Mini: Delete Buffer",
      },
      {
        "<leader>bD",
        function()
          for _, v in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[v].bufhidden ~= "hide" then
              require("mini.bufremove").delete(v, false)
            end
          end
        end,
        desc = "Mini: Delete All Buffers",
      },
      {
        "<leader>bw",
        function()
          require("mini.bufremove").wipeout(0, false)
        end,
        desc = "Mini: Wipeout Buffer",
      },
      {
        "<leader>bW",
        function()
          for _, v in ipairs(vim.api.nvim_list_bufs()) do
            if vim.bo[v].bufhidden ~= "hide" then
              require("mini.bufremove").wipeout(v, false)
            end
          end
        end,
        desc = "Mini: Wipeout All Buffers",
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

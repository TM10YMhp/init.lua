return {
  "rebelot/heirline.nvim",
  event = "VeryLazy",
  opts = {
    opts = {
      disable_winbar_cb = function()
        return vim.fn.win_gettype() == "popup" or vim.o.filetype == "neo-tree"
      end,
    },
    winbar = {
      {
        init = function(self)
          local data = ""

          if vim.api.nvim_buf_get_option(0, "buftype") == "" then
            data = vim.fn.expand("%:~:.") or "[No Name]"
          else
            data = vim.fn.expand("%:t")
          end

          if data == "" then
            data = "[No Name]"
          end

          self.data = "> " .. data
        end,
        provider = function(self)
          return self.data
        end,
        update = { "BufEnter" },
      },
    },
  },
  config = function(_, opts)
    require("heirline").setup(opts)

    vim.opt_local.winbar = "%{%v:lua.require'heirline'.eval_winbar()%}"
  end,
}

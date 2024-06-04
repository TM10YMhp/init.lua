return {
  "rebelot/heirline.nvim",
  event = "VeryLazy",
  opts = {
    opts = {
      disable_winbar_cb = function()
        return vim.fn.win_gettype() == "popup"
          or not vim.list_contains({ "", "help" }, vim.o.buftype)
          or vim.list_contains({ "dashboard" }, vim.o.filetype)
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

    if not opts.opts.disable_winbar_cb() then
      vim.opt_local.winbar = "%{%v:lua.require'heirline'.eval_winbar()%}"
    end
  end,
}

return {
  "rebelot/heirline.nvim",
  event = vim.fn.argc(-1) == 0 and "BufAdd" or "VeryLazy",
  opts = {
    opts = {
      disable_winbar_cb = function()
        if vim.list_contains({ "fugitiveblame" }, vim.o.filetype) then
          return false
        end

        return vim.fn.win_gettype() == "popup"
          or not vim.list_contains({ "", "help" }, vim.o.buftype)
          or vim.list_contains({ "dashboard" }, vim.o.filetype)
      end,
    },
    winbar = {
      SereneNvim.heirline.absolute_path,
    },
  },
  config = function(_, opts)
    require("heirline").setup(opts)

    if not opts.opts.disable_winbar_cb() then
      vim.opt_local.winbar = "%{%v:lua.require'heirline'.eval_winbar()%}"
    end
  end,
}

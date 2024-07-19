return {
  "luukvbaal/statuscol.nvim",
  event = SereneNvim.lazy_init and "BufAdd" or "VeryLazy",
  opts = function()
    local builtin = require("statuscol.builtin")

    return {
      ft_ignore = { "fugitive", "dashboard", "bigfile" },
      bt_ignore = { "terminal", "help" },
      relculright = false,
      segments = {
        { text = { builtin.foldfunc } },
        {
          sign = {
            text = { ".*" },
            namespace = { "diagnostic/signs" },
            colwidth = 1,
            wrap = true,
            foldclosed = true,
          },
          condition = { builtin.not_empty },
        },
        { text = { builtin.lnumfunc } },
        {
          text = { " " },
          condition = { builtin.not_empty },
        },
      },
    }
  end,
  config = function(_, opts)
    require("statuscol").setup(opts)

    vim.api.nvim_exec_autocmds(
      "Filetype",
      { group = "StatusCol", modeline = false }
    )
  end,
}

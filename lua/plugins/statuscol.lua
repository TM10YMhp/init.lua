return {
  "luukvbaal/statuscol.nvim",
  event = vim.fn.argc(-1) == 0 and "BufAdd" or "VeryLazy",
  opts = function()
    local builtin = require("statuscol.builtin")

    return {
      ft_ignore = { "fugitive" },
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
}

return {
  "luukvbaal/statuscol.nvim",
  event = "VeryLazy",
  opts = function()
    local builtin = require("statuscol.builtin")

    return {
      bt_ignore = { "terminal" },
      relculright = false,
      segments = {
        { text = { builtin.foldfunc } },
        {
          sign = {
            text = { ".*" },
            namespace = { "diagnostic/signs" },
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

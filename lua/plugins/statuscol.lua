return {
  "luukvbaal/statuscol.nvim",
  event = "VeryLazy",
  opts = function()
    local builtin = require("statuscol.builtin")

    return {
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
        {
          text = { builtin.lnumfunc, " " },
          condition = { true, builtin.not_empty },
        },
      },
    }
  end,
}

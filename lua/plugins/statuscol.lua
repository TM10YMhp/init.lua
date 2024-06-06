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
        },
        {
          text = { builtin.lnumfunc, " " },
          condition = { true, builtin.not_empty },
        },
      },
    }
  end,
}

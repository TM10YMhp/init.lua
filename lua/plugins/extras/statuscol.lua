return {
  {
    "luukvbaal/statuscol.nvim",
    event = "VeryLazy",
    opts = function()
      local builtin = require("statuscol.builtin")

      return {
        -- relculright = true,
        segments = {
          { text = { builtin.foldfunc } },
          { text = { "%s" } },
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
          },
        }
      }
    end
  },
}

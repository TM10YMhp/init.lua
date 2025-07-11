return {
  "luukvbaal/statuscol.nvim",
  event = "VeryLazy",
  opts = function()
    local builtin = require("statuscol.builtin")

    return {
      ft_ignore = {
        "fugitive",
        "dashboard",
        "bigfile",
        "lazy",
        "dbui",
        "bigfile",
        "NvimTree",
        "snacks_picker_preview",
      },
      bt_ignore = {
        "terminal",
        "help",
        -- "nofile",
      },
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

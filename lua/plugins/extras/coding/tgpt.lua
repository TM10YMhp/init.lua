return {
  "voldikss/vim-floaterm",
  optional = true,
  keys = {
    {
      "<M-t>a",
      "<cmd>FloatermNew --wintype=split --height=0.35 tgpt -i<cr>",
      desc = "TGPT",
    },
    {
      "<M-t>A",
      function()
        local file = vim.api.nvim_buf_get_name(0)
        local term = "FloatermNew --wintype=split --height=0.35 --autoclose=0"
        vim.cmd(term .. " cat " .. file .. ' | tgpt "Califica el código"')
      end,
      desc = "Califica el código",
    },
  },
}

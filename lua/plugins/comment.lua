return {
  "numToStr/Comment.nvim",
  keys = {
    { "gcO", desc = "Comment insert above" },
    { "gco", desc = "Comment insert below" },
    { "gc", desc = "Comment toggle linewise" },
    { "gb", desc = "Comment toggle blockwise" },
    { "gcA", desc = "Comment insert end of line" },
    { "gcc", desc = "Comment toggle current line" },
    { "gbc", desc = "Comment toggle current block" },
    { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
    { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
  },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
    opts = {
      enable_autocmd = false,
    }
  },
  opts = function()
    return {
      padding = true,
      sticky = true,
      ignore = nil,
      toggler = {
        line = 'gcc',
        block = 'gbc'
      },
      opleader = {
        line = 'gc',
        block = 'gb'
      },
      extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA'
      },
      mappings = {
        basic = true,
        extra = true
      },
      pre_hook = require('ts_context_commentstring.integrations.comment_nvim')
        .create_pre_hook(),
      post_hook = nil,
    }
  end
}

return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.skip_ts_context_commentstring_module = true
  end,
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

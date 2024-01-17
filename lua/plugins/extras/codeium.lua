return {
  "Exafunction/codeium.vim",
  -- event = "VeryLazy", -- Await Auth
  event = "InsertEnter",
  cmd = "Codeium",
  init = function()
    vim.g.codeium_enabled = true
    vim.g.codeium_disable_bindings = 1
    vim.g.codeium_no_map_tap = true
  end,
  keys = {
    {
      "<M-y>",
      function() return vim.fn['codeium#Accept']() end,
      mode = "i",
      desc = "Codeium: Accept",
      expr = true,
      silent = true,
    },
    {
      "<M-e>",
      function() return vim.fn['codeium#Clear']() end,
      mode = "i",
      desc = "Codeium: Clear",
      expr = true,
      silent = true,
    },
    {
      "<M-n>",
      function() return vim.fn['codeium#CycleOrComplete']() end,
      mode = "i",
      desc = "Codeium: Next Completion",
      expr = true,
      silent = true,
    },
    {
      "<M-p>",
      function() return vim.fn['codeium#CycleCompletions'](-1) end,
      mode = "i",
      desc = "Codeium: Prev Completion",
      expr = true,
      silent = true,
    },
    {
      "<leader>ua",
      function()
        local utils = require("tm10ymhp.utils")
        if vim.g.codeium_enabled then
          vim.g.codeium_enabled = false
          utils.info("Codeium disabled")
        else
          vim.g.codeium_enabled = true
          utils.info("Codeium enabled")
        end
      end,
      desc = "Toggle Codeium"
    },
  },
  config = function()
    vim.api.nvim_create_autocmd('ColorScheme', {
      group = vim.api.nvim_create_augroup('Codeium', { clear = true }),
      desc = "Set Codeium Suggestion highlight",
      callback = function()
        vim.api.nvim_set_hl(0, 'CodeiumSuggestion', { link = "Comment" })
      end
    })
  end
}

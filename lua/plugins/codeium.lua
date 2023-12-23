return {
  "Exafunction/codeium.vim",
  -- event = "VeryLazy", -- Await Auth
  event = "InsertEnter",
  cmd = "Codeium",
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
        if vim.g.codeium_enabled then
          vim.g.codeium_enabled = false
          utils.notify("Codeium disabled")
        else
          vim.g.codeium_enabled = true
          utils.notify("Codeium enabled")
        end
      end,
      desc = "Toggle Codeium"
    },
  },
}

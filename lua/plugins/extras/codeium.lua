return {
  "Exafunction/codeium.vim",
  event = "InsertEnter",
  cmd = "Codeium",
  init = function()
    vim.g.codeium_enabled = true
    vim.g.codeium_disable_bindings = 1
    vim.g.codeium_no_map_tap = true
  end,
  keys = {
    {
      "<M-c>",
      -- TODO: check this
      "codeium#Chat()",
      desc = "Codeium: Chat - Telemetry",
      expr = true,
      silent = true,
    },
    {
      "<Tab>",
      "codeium#Accept()",
      mode = "i",
      desc = "Codeium: Accept",
      expr = true,
      silent = true,
    },
    {
      "<M-y>",
      vim.fn["codeium#Accept"],
      mode = "i",
      desc = "Codeium: Accept",
      expr = true,
      silent = true,
    },
    {
      "<M-e>",
      "codeium#Clear()",
      mode = "i",
      desc = "Codeium: Clear",
      expr = true,
      silent = true,
    },
    {
      "<M-n>",
      "<cmd>call codeium#CycleOrComplete()<cr>",
      mode = "i",
      desc = "Codeium: Next Completion",
      silent = true,
    },
    {
      "<M-p>",
      "<cmd>call codeium#CycleCompletions(-1)<cr>",
      mode = "i",
      desc = "Codeium: Prev Completion",
      silent = true,
    },
    {
      "<leader>ti",
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
      desc = "Toggle Codeium",
    },
  },
  config = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("Codeium", { clear = true }),
      desc = "Set Codeium Suggestion highlight",
      callback = function()
        vim.api.nvim_set_hl(0, "CodeiumSuggestion", { link = "Comment" })
      end,
    })

    vim.fn["codeium#command#StartLanguageServer"]()
  end,
}

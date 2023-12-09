return {
  {
    "Exafunction/codeium.vim",
    -- enabled = false,
    event = "VeryLazy", -- Await Auth
    init = function()
      vim.g.codeium_filetypes = {
        oil = false,
        TelescopePrompt = false,
        NvimTree = false,
        minifiles = false,
      }
      vim.g.codeium_enabled = true
      vim.g.codeium_disable_bindings = 1
      vim.g.codeium_no_map_tap = true
    end,
    config = function()
      vim.keymap.set(
        'i',
        '<M-y>',
        function () return vim.fn['codeium#Accept']() end,
        {
          silent = true,
          expr = true,
          script = true,
          nowait = true,
          desc = "Codeium: Accept"
        }
      )
      vim.keymap.set(
        'i',
        '<M-e>',
        function() return vim.fn['codeium#Clear']() end,
        {
          silent = true,
          expr = true,
          script = true,
          nowait = true,
          desc = "Codeium: Clear"
        }
      )
      vim.keymap.set(
        'i',
        '<M-n>',
        function() return vim.fn['codeium#CycleOrComplete']() end,
        {
          expr = true,
          desc = "Codeium: Next Completion"
        }
      )
      vim.keymap.set(
        'i',
        '<M-p>',
        function() return vim.fn['codeium#CycleCompletions'](-1) end,
        {
          expr = true,
          desc = "Codeium: Prev Completion"
        }
      )

      local utils = require("tm10ymhp.utils")

      vim.keymap.set("n", "<leader>ua", function()
        if vim.g.codeium_enabled then
          vim.g.codeium_enabled = false
          utils.notify("Codeium disabled")
        else
          vim.g.codeium_enabled = true
          utils.notify("Codeium enabled")
        end
      end, { desc = "Toggle Codeium" })
    end
  },
  -- {
  --   "Exafunction/codeium.nvim",
  --   enabled = false,
  --   event = "VeryLazy", -- Await Auth
  --   config = function()
  --     require("codeium").setup({})
  --   end
  -- }
}

-- TODO: check cache
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    {
      "Exafunction/codeium.nvim",
      cmd = "Codeium",
      opts = {},
    },
  },
  opts = function(_, opts)
    opts.sources = opts.sources or {}
    table.insert(opts.sources, 2, {
      name = "codeium",
      group_index = 1,
    })
  end,
}

-- return {
--   "Exafunction/codeium.vim",
--   enabled = false,
--   event = "InsertEnter",
--   cmd = "Codeium",
--   -- TODO: https://github.com/Exafunction/codeium.vim/issues/376
--   commit = "289eb72",
--   init = function()
--     vim.g.codeium_enabled = true
--     vim.g.codeium_disable_bindings = 1
--     vim.g.codeium_no_map_tap = true
--   end,
--   keys = {
--     {
--       "<M-c>",
--       -- TODO: check this
--       "codeium#Chat()",
--       desc = "Codeium: Chat - Telemetry",
--       expr = true,
--       silent = true,
--     },
--     {
--       "<Tab>",
--       "codeium#Accept()",
--       mode = "i",
--       desc = "Codeium: Accept",
--       expr = true,
--       silent = true,
--     },
--     {
--       "<M-y>",
--       vim.fn["codeium#Accept"],
--       mode = "i",
--       desc = "Codeium: Accept",
--       expr = true,
--       silent = true,
--     },
--     {
--       "<M-e>",
--       "codeium#Clear()",
--       mode = "i",
--       desc = "Codeium: Clear",
--       expr = true,
--       silent = true,
--     },
--     {
--       "<M-n>",
--       "<cmd>call codeium#CycleOrComplete()<cr>",
--       mode = "i",
--       desc = "Codeium: Next Completion",
--       silent = true,
--     },
--     {
--       "<M-p>",
--       "<cmd>call codeium#CycleCompletions(-1)<cr>",
--       mode = "i",
--       desc = "Codeium: Prev Completion",
--       silent = true,
--     },
--     {
--       "<leader>ti",
--       function()
--         if vim.g.codeium_enabled then
--           vim.g.codeium_enabled = false
--           SereneNvim.info("Codeium disabled")
--         else
--           vim.g.codeium_enabled = true
--           SereneNvim.info("Codeium enabled")
--         end
--       end,
--       desc = "Toggle Codeium",
--     },
--   },
--   config = function()
--     vim.api.nvim_create_autocmd("ColorScheme", {
--       group = vim.api.nvim_create_augroup("Codeium", { clear = true }),
--       desc = "Set Codeium Suggestion highlight",
--       callback = function()
--         vim.api.nvim_set_hl(0, "CodeiumSuggestion", { link = "Comment" })
--       end,
--     })
--
--     vim.fn["codeium#command#StartLanguageServer"]()
--   end,
-- }

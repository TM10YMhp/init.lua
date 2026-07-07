-- SereneNvim.on_lazy_init(function()
--   vim.filetype.add({
--     pattern = {
--       -- match filenames like - ".env.example", ".env.local" and so on
--       ["%.env%.[%w_.-]+"] = "sh",
--     },
--   })
-- end)

return {
  -- TODO: check update
  "zeybek/camouflage.nvim",
  event = "VeryLazy",
  keys = {
    { "<leader>oC", "<cmd>CamouflageToggle<cr>", desc = "Toggle Camouflage" },
  },
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*.json",
      callback = function() vim.b.camouflage_enabled = false end,
    })
    --   SereneNvim.on_very_lazy(function()
    --     Snacks.toggle
    --       .new({
    --         name = "Camouflage",
    --         get = function() return require("camouflage").is_enabled() end,
    --         set = function(state)
    --           local camouflage = require("camouflage")
    --           if state then
    --             camouflage.enable()
    --           else
    --             camouflage.disable()
    --           end
    --         end,
    --       })
    --       :map("<leader>oC")
    --   end)
  end,
  opts = {
    pwned = { enabled = false },
    project_config = { enabled = false },
  },
}

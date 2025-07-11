-- same telescope-undo
return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 4
    vim.g.undotree_DiffpanelHeight = 30
    vim.g.undotree_DiffAutoOpen = 0
    vim.g.undotree_ShortIndicators = 1
  end,
}

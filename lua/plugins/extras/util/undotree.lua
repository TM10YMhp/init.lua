-- same telescope-undo
return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    { "<leader>fg", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
  },
  config = function()
    vim.g.undotree_WindowLayout = 4
    vim.g.undotree_DiffpanelHeight = 30
    vim.g.undotree_DiffAutoOpen = 0
  end,
}

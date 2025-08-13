return {
  "MagicDuck/grug-far.nvim",
  cmd = { "GrugFar", "GrugFarWithin" },
  keys = {
    { "<leader>ug", "<cmd>GrugFar<cr>", desc = "Grug Far" },
  },
  opts = {
    transient = true,
    windowCreationCommand = "botright split",
    showCompactInputs = true,
    openTargetWindow = {
      preferredLocation = "prev",
    },
    icons = { enabled = true },
    keymaps = {
      openNextLocation = { n = "" },
      openPrevLocation = { n = "" },
    },
  },
}

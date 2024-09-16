return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>zz",
      function()
        local grug = require("grug-far")
        local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
        grug.grug_far({
          prefills = {
            filesFilter = ext and ext ~= "" and "*." .. ext or nil,
          },
        })
      end,
      mode = { "n", "v" },
      desc = "Search and Replace",
    },
  },
  opts = {
    windowCreationCommand = "split",
    startInInsertMode = false,
    transient = true,
    resultsSeparatorLineChar = "",
    spinnerStates = false,
    icons = {
      actionEntryBullet = "",

      searchInput = "",
      replaceInput = "",
      filesFilterInput = "",
      flagsInput = "",
      pathsInput = "",

      resultsStatusReady = "",
      resultsStatusError = "",
      resultsStatusSuccess = "",
      resultsActionMessage = "",
      resultsEngineLeft = "",
      resultsEngineRight = "",
      resultsChangeIndicator = "",
      resultsAddedIndicator = "",
      resultsRemovedIndicator = "",
      resultsDiffSeparatorIndicator = "",
      historyTitle = "",
      helpTitle = "",
    },
  },
}
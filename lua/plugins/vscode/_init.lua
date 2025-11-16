if not vim.g.vscode then return {} end

local enabled = {
  "dial.nvim",
  "lazy.nvim",
  "mini.ai",
  "mini.extra",
  "mini.operators",
  "nvim-surround",
  "nvim-treesitter",
  "nvim-treesitter-endwise",
  "nvim-treesitter-textobjects",
  "vim-cool",
  "vim-matchup",
  "flash.nvim",
  "mini.align",
  "treesj",
  "vim-eunuch",
  "vim-indent-object",
  "vim-ipmotion",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}

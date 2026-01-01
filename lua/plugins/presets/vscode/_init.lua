if not vim.g.vscode then return {} end

local enabled = {
  "dial.nvim",
  "flash.nvim",
  "lazy.nvim",
  "mini.ai",
  "mini.align",
  "mini.extra",
  "mini.operators",
  "nvim-surround",
  "nvim-treesitter",
  "nvim-treesitter-textobjects",
  "mini.splitjoin",
  "treesj",
  "vim-cool",
  "vim-indent-object",
  "vim-ipmotion",
  "vim-matchup",
}

local Config = require("lazy.core.config")
Config.options.checker.enabled = false
Config.options.change_detection.enabled = false
Config.options.defaults.cond = function(plugin)
  return vim.tbl_contains(enabled, plugin.name) or plugin.vscode
end

local vscode = require("vscode")

-- ---@return boolean
-- local is_first_startup = function()
--   local name_var = "vscode.vscode_neovim_activated"
--   local activated = vscode.eval(("return !!%s"):format(name_var))
--   if activated then return false end
--   vscode.eval(("%s = true"):format(name_var))
--   return true
-- end
--
-- if is_first_startup() then vscode.action("vscode-neovim.stop") end

-- NOTE: toggle neovim
-- - https://github.com/vscode-neovim/vscode-neovim/pull/1566#issuecomment-1852111050
-- {
--   "key": "alt+t",
--   "command": "vscode-neovim.stop",
--   "when": "neovim.init"
-- },
-- {
--   "key": "alt+t",
--   "command": "vscode-neovim.restart",
--   "when": "!neovim.init"
-- }

vim.notify = vscode.notify

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { highlight = { enable = false } },
  },
}

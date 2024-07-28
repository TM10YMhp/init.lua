_G.SereneNvim = require("util")

local M = {}

SereneNvim.config = M

local config = {
  bigfile_size = 1, -- 1 MB
  icons = {
    -- https://code.visualstudio.com/docs/editor/intellisense#_types-of-completions
    -- stylua: ignore
    kinds = {
      Text          = "w",
      Method        = "m",
      Function      = "m",
      Constructor   = "m",
      Field         = "n",
      Variable      = "v",
      Class         = "c",
      Interface     = "I",
      Module        = "M",
      Property      = "p",
      Unit          = "u",
      Value         = "E",
      Enum          = "E",
      Keyword       = "k",
      Snippet       = "s",
      Color         = "C",
      File          = "F",
      Reference     = "r",
      Folder        = "D",
      EnumMember    = "E",
      Constant      = "C",
      Struct        = "S",
      Event         = "e",
      Operator      = "o",
      TypeParameter = "T",
      Codeium       = "★",
    },
    -- stylua: ignore
    sources = {
      buffer           = "Buf",
      nvim_lsp         = "LSP",
      luasnip          = "Snip",
      nvim_lua         = "Lua",
      latex_symbols    = "LTX",
      obsidian         = "Obs",
      obsidian_new     = "New",
      ["buffer-lines"] = "BufL",
      codeium          = "AI",
    },
    -- stylua: ignore
    gitsigns = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "-" },
      changedelete = { text = "~" },
      untracked    = { text = "." },
    },
  },
  extras = {
    obsidian_dir = "~/vaults/notes_md",
  },
}

M.did_init = false
function M.init()
  if M.did_init then
    return
  end
  M.did_init = true

  require("config.options") -- call before lazy.nvim
  require("config.autocmds") -- check BufReadPost
  require("config.lazy")
end

setmetatable(M, {
  __index = function(t, k)
    t[k] = config[k]
    return t[k]
  end,
})

return M

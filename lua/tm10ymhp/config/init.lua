_G.SereneNvim = require("tm10ymhp.util")

local M = {}

SereneNvim.config = {
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
      Codeium       = "A",
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
  },
  extras = {
    obsidian_dir = "~/vaults/notes_md",
  },
}

return M

SereneNvim.config = {
  -- bigfile_size = 1024 * 1024 -- 1024kb == 1MB
  -- bigfile_size = 1024 * 512 -- 512kb
  bigfile_size = 1024 * 896, -- 896kb
  icons = {
    -- https://code.visualstudio.com/docs/editor/intellisense#_types-of-completions
    -- stylua: ignore
    kinds = {
      Text          = "w",
      Method        = "f",
      Function      = "f",
      Constructor   = "m",
      Field         = "m",
      Variable      = "v",
      Class         = "m",
      Interface     = "I",
      Module        = "M",
      Property      = "p",
      Unit          = "u",
      Value         = "E",
      Enum          = "E",
      Keyword       = "k",
      Snippet       = "s",
      Color         = "c",
      File          = "F",
      Reference     = "r",
      Folder        = "D",
      EnumMember    = "E",
      Constant      = "d",
      Struct        = "m",
      Event         = "e",
      Operator      = "o",
      TypeParameter = "t",

      Codeium       = "*",
      Supermaven    = "*",
      Copilot       = "*",
      NerdFont      = "",
      Latex         = "x",
      Agda          = "a",
    },
    -- stylua: ignore
    sources = {
      buffer           = "[B]",
      nvim_lsp         = "[L]",
      luasnip          = "[S]",
      nvim_lua         = "[V]",
      latex_symbols    = "[X]",
      obsidian         = "[O]",
      obsidian_new     = "[N]",
      ["buffer-lines"] = "[B]",
      codeium          = "[I]",
    },
    -- stylua: ignore
    gitsigns = {
      add          = { text = "│" },
      change       = { text = "┆" },
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

-- vim.g.serene_nvim = config
-- local default_config = require("config.default")
-- local config = vim.tbl_deep_extend("force", default_config, vim.g.serene_nvim or {})
-- return config

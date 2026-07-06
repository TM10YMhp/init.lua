return {
  {
    "jackplus-xyz/binary.nvim",
    event = "CmdlineEnter :",
    opts = {},
  },
  {
    "projekt0n/github-nvim-theme",
    main = "github-theme",
    event = "CmdlineEnter :",
    opts = {},
  },
  {
    "scottmckendry/cyberdream.nvim",
    event = "CmdlineEnter :",
    opts = { transparent = true },
  },
  {
    "Shatur/neovim-ayu",
    event = "CmdlineEnter :",
    name = "ayu",
    opts = {
      overrides = {
        Comment = {
          fg = "#626a73",
          italic = false,
        },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    event = "CmdlineEnter :",
    opts = {
      style = "night",
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
    },
  },
  {
    "rose-pine/neovim",
    event = "CmdlineEnter :",
    name = "rose-pine",
    opts = {
      styles = {
        bold = false,
        italic = false,
        transparency = true,
      },
    },
  },
}

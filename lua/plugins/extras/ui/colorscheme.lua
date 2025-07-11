return {
  {
    "tm10ymhp/serene.nvim",
    -- dev = true,
    branch = "dev",
    event = "UIEnter",
    config = function()
      -- https://github.com/jackplus-xyz/binary.nvim
      require("serene").load()
    end,
  },
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
    "neko-night/nvim",
    name = "nekonight",
    event = "CmdlineEnter :",
    init = function()
      SereneNvim.hacks.on_module("nekonight", function(mod)
        local load = mod.load
        function mod.load(opts)
          if type(opts.style) == "boolean" and opts.style == false then
            opts.style = "night"
          end
          return load(opts)
        end
      end)
    end,
    opts = {
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
      },
    },
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

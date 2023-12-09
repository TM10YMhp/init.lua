return {
  {
    "tm10ymhp/serene.nvim-dev",
    dev = true,
    event = "UIEnter",
    config = function ()
      vim.cmd[[colorscheme serene]]
    end
  },
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
    opts = {
      transparent = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = "transparent"
      }
    }
  },
  {
    "Mofiqul/vscode.nvim",
    event = "VeryLazy",
    opts = {
      transparent = true,
      italic_comments = false,
      disable_nvimtree_bg = true,
    }
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    event = "VeryLazy",
    config = function()
      require("rose-pine").setup({
        disable_background = true,
        disable_float_background = true,
        disable_italics = true,
      })
    end
  },
  {
    "craftzdog/solarized-osaka.nvim",
    event = "VeryLazy",
    opts = {
      transparent = true,
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = "transparent"
      }
    }
  },
}

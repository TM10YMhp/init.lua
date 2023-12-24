return {
  {
    "tm10ymhp/serene.nvim",
    -- dev = true,
    branch = "dev",
    event = "UIEnter",
    opts = {
      termguicolors = false
    },
    config = function(_, opts)
      require("serene").setup(opts)

      vim.cmd.colorscheme("serene")
    end
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
    opts = {
      disable_background = true,
      disable_float_background = true,
      disable_italics = true,
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
    end
  },
}

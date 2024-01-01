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
    "Shatur/neovim-ayu",
    event = "VeryLazy",
    opts = {
      overrides = {
        Comment = { fg = "#626a73" },
      }
    },
    config = function(_, opts)
      require("ayu").setup(opts)
    end
  },
}

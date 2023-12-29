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
    "rebelot/kanagawa.nvim",
    event = "VeryLazy",
    opts = {
      undercurl = false,
      commentStyle   = { italic = false },
      keywordStyle   = { italic = false },
      statementStyle = { bold   = false },
      transparent = true,
    }
  },
}

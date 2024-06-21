return {
  {
    "tm10ymhp/serene.nvim",
    -- dev = true,
    branch = "dev",
    event = "UIEnter",
    opts = {
      termguicolors = false,
    },
    config = function(_, opts)
      require("serene").setup(opts)
      vim.cmd.colorscheme("serene")
    end,
  },
  {
    "ellisonleao/gruvbox.nvim",
    event = "CmdlineEnter :",
    opts = {
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
      contrast = "hard",
    },
  },
  {
    "scottmckendry/cyberdream.nvim",
    event = "CmdlineEnter :",
    opts = {
      transparent = true,
      borderless_telescope = false,
    },
  },
  {
    "Mofiqul/vscode.nvim",
    event = "CmdlineEnter :",
    opts = {},
  },
  {
    "Shatur/neovim-ayu",
    event = "CmdlineEnter :",
    name = "ayu",
    opts = {
      overrides = {
        Comment = { fg = "#626a73" },
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
    "rebelot/kanagawa.nvim",
    event = "CmdlineEnter :",
    opts = {
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
    },
  },
  {
    "catppuccin/nvim",
    event = "CmdlineEnter :",
    name = "catppuccin",
    opts = {
      no_italic = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        diffview = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
}

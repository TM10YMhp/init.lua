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
    "scottmckendry/cyberdream.nvim",
    event = "CmdlineEnter",
    opts = {
      transparent = true,
      borderless_telescope = false,
    },
  },
  {
    "marko-cerovac/material.nvim",
    event = "CmdlineEnter",
    init = function()
      vim.g.material_style = "deep ocean"
    end,
    opts = {
      high_visibility = {
        darker = true,
      },
      plugins = {
        "coc",
        "dap",
        "dashboard",
        "eyeliner",
        "fidget",
        "flash",
        "gitsigns",
        "harpoon",
        "hop",
        "illuminate",
        "indent-blankline",
        "lspsaga",
        "mini",
        "neogit",
        "neotest",
        "neo-tree",
        "neorg",
        "noice",
        "nvim-cmp",
        "nvim-navic",
        "nvim-tree",
        "nvim-web-devicons",
        "rainbow-delimiters",
        "sneak",
        "telescope",
        "trouble",
        "which-key",
        "nvim-notify",
      },
    },
  },
  {
    "Shatur/neovim-ayu",
    event = "CmdlineEnter",
    name = "ayu",
    opts = {
      overrides = {
        Comment = { fg = "#626a73" },
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    event = "CmdlineEnter",
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
    event = "CmdlineEnter",
    opts = {
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
    },
  },
  {
    "catppuccin/nvim",
    event = "CmdlineEnter",
    name = "catppuccin",
    opts = {
      no_italic = true,
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
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

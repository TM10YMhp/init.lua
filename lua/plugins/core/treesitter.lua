return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    init = function()
      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/commit/0d7c800fadcfe2d33089f5726cb8907fc846eece
      vim.g.no_plugin_maps = true
    end,
  },
  {
    "nvim-treesitter",
    optional = true,
    dependencies = { "RRethy/nvim-treesitter-endwise" },
  },
  {
    -- NOTE: aunque ensure_installed puede volver a funcionar, lo ideal seria
    -- instalarlos segun sea necesario.
    "nvim-treesitter/nvim-treesitter",
    -- event = "VeryLazy",
    lazy = false,
    opts = function()
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo.foldmethod = "expr"

      return {}
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {
      aliases = {
        ["vue"] = "typescriptreact",
      },
    },
    config = function(_, opts)
      require("nvim-ts-autotag").setup(opts)

      -- HACK: attach not work bufnr
      SereneNvim.bufdo(function(bufnr)
        if vim.api.nvim_get_current_buf() == bufnr then return end
        vim.api.nvim_buf_call(bufnr, function() require("nvim-ts-autotag.internal").attach() end)
      end)
    end,
  },
  {
    -- NOTE: a util
    "aaronik/treewalker.nvim",
    cmd = "Treewalker",
    keys = {
      {
        "<M-s>",
        "<cmd>Treewalker Down<cr>",
        mode = { "n", "x" },
        desc = "Treewalker Down",
      },
      {
        "<M-w>",
        "<cmd>Treewalker Up<cr>",
        mode = { "n", "x" },
        desc = "Treewalker Up",
      },
      {
        "<M-a>",
        "<cmd>Treewalker Left<cr>",
        mode = { "n", "x" },
        desc = "Treewalker Left",
      },
      {
        "<M-d>",
        "<cmd>Treewalker Right<cr>",
        mode = { "n", "x" },
        desc = "Treewalker Right",
      },
      {
        "<M-q>",
        "<cmd>Treewalker SwapLeft<cr>",
        desc = "Treewalker SwapLeft",
      },
      {
        "<M-e>",
        "<cmd>Treewalker SwapRight<cr>",
        desc = "Treewalker SwapRight",
      },
    },
    opts = {
      highlight = false,
    },
  },
}

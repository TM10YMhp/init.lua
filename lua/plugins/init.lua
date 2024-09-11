return {
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        "<cmd>lua require('neogen').generate()<CR>",
        desc = "Neogen Comment",
      },
    },
    opts = {
      snippet_engine = "luasnip",
    },
  },
  {
    "mattn/emmet-vim",
    keys = { "<M-e>" },
    init = function()
      vim.g.user_emmet_leader_key = "<M-e>"
    end,
  },
  -- same telescope-undo
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>fg", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 4
      vim.g.undotree_DiffpanelHeight = 30
      vim.g.undotree_DiffAutoOpen = 0
    end,
  },
  {
    "tzachar/highlight-undo.nvim",
    keys = { "u", "<c-r>" },
    opts = {
      duration = 100,
      undo = { hlgroup = "Search" },
      redo = { hlgroup = "Search" },
    },
  },
  {
    "jinh0/eyeliner.nvim",
    keys = {
      { "f", mode = { "n", "o", "x" }, desc = "Jump forward" },
      { "F", mode = { "n", "o", "x" }, desc = "Jump backward" },
      { "t", mode = { "n", "o", "x" }, desc = "Jump forward till" },
      { "T", mode = { "n", "o", "x" }, desc = "Jump backward till" },
    },
    opts = {
      highlight_on_key = true,
      match = "[a-zA-Z0-9]",
    },
  },
  {
    "tpope/vim-sleuth",
    cmd = "Sleuth",
    keys = {
      {
        "<leader>ce",
        function()
          SereneNvim.info("Detect Indent")
          vim.schedule(function()
            vim.cmd("Sleuth")
          end)
        end,
        desc = "Detect Indent",
      },
    },
  },
  {
    "tpope/vim-eunuch",
    -- stylua: ignore
    cmd = {
      "Unlink",
      "Remove",
      "Delete",
      "Move", "Rename", "Copy", "Duplicate",
      "Chmod",
      "Mkdir",
      "Cfind", "Clocate",
      "Lfind", "Llocate",
      "SudoWrite",
      "SudoEdit",
      "Wall", "W",
    },
  },
  {
    "romainl/vim-cool",
    event = "VeryLazy",
  },
  -- NOTE: cursormove fire cmdlineenter?
  {
    "Aasim-A/scrollEOF.nvim",
    event = "VeryLazy",
    opts = { insert_mode = true },
  },
  {
    "tonymajestro/smart-scrolloff.nvim",
    event = "VeryLazy",
    opts = {
      scrolloff_percentage = 0.2,
    },
    config = function(_, opts)
      require("smart-scrolloff").setup(opts)

      vim.api.nvim_create_autocmd("WinResized", {
        callback = function()
          if vim.o.buftype == "terminal" then
            vim.opt_local.scrolloff = 0
          end
        end,
      })
    end,
  },
  {
    "BranimirE/fix-auto-scroll.nvim",
    event = "BufLeave",
    config = true,
  },
}

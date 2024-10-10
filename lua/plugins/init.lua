return {
  {
    "echasnovski/mini.statusline",
    event = "VeryLazy",
    opts = {
      content = {
        active = function()
          local mode, mode_hl =
            MiniStatusline.section_mode({ trunc_width = 120 })
          local git =
            MiniStatusline.section_git({ trunc_width = 40, icon = "" })
          local diff =
            MiniStatusline.section_diff({ trunc_width = 75, icon = "" })
          local diagnostics =
            MiniStatusline.section_diagnostics({ trunc_width = 75, icon = "" })
          local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
          local fileinfo =
            MiniStatusline.section_fileinfo({ trunc_width = 120 })
          local location = MiniStatusline.section_location({ trunc_width = 75 })

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            {
              hl = "MiniStatuslineDevinfo",
              strings = { git, diff, diagnostics },
            },
            "%<", -- Mark general truncate point
            { hl = "MiniStatuslineFilename", strings = { location } },
            "%=", -- End left alignment
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo, lsp } },
            { hl = mode_hl, strings = {} },
          })
        end,
      },
      use_icons = false,
      set_vim_settings = false,
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
      keymaps = {
        undo = { hlgroup = "Search" },
        redo = { hlgroup = "Search" },
      },
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

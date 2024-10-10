return {
  {
    "echasnovski/mini.statusline",
    event = "VeryLazy",
    opts = {
      content = {
        active = function()
          local mode, mode_hl =
            MiniStatusline.section_mode({ trunc_width = 120 })
          -- TODO: check this
          local diagnostics =
            MiniStatusline.section_diagnostics({ trunc_width = 75, icon = "" })
          local lsp =
            MiniStatusline.section_lsp({ trunc_width = 75, icon = "" })

          local get_filesize = function()
            local size = vim.fn.getfsize(vim.fn.getreg("%"))
            if size < 1024 then
              return string.format("%dB", size)
            elseif size < 1048576 then
              return string.format("%.2fK", size / 1024)
            else
              return string.format("%.2fM", size / 1048576)
            end
          end

          return MiniStatusline.combine_groups({
            { hl = mode_hl, strings = { mode } },
            {
              hl = "MiniStatuslineDevinfo",
              strings = { vim.b.gitsigns_head },
            },
            "%<", -- Mark general truncate point
            {
              hl = "MiniStatuslineFilename",
              strings = {
                '%l:%{charcol(".")}|%{charcol("$")-1}',
                "%=", -- End left alignment
                "%{get(b:,'gitsigns_status','')}",
                diagnostics,
                vim.o.encoding,
                vim.o.fileformat,
                lsp,
                vim.o.filetype,
              },
            },
            {
              hl = "MiniStatuslineFileinfo",
              strings = { get_filesize() },
            },
            { hl = mode_hl, strings = { "%L" } },
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

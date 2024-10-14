return {
  {
    "echasnovski/mini.statusline",
    event = "VeryLazy",
    opts = {
      content = {
        active = function()
          local mode, mode_hl =
            MiniStatusline.section_mode({ trunc_width = 120 })

          local workspace_diagnostic = function()
            local res = {
              [vim.diagnostic.severity.ERROR] = 0,
              [vim.diagnostic.severity.WARN] = 0,
              [vim.diagnostic.severity.INFO] = 0,
              [vim.diagnostic.severity.HINT] = 0,
            }
            for _, v in ipairs(vim.diagnostic.get()) do
              res[v.severity] = res[v.severity] + 1
            end

            local errors = res[1]
            local warnings = res[2]
            local infos = res[3]
            local hints = res[4]

            return vim.trim(
              (errors > 0 and "E" .. errors .. " " or "")
                .. (warnings > 0 and "W" .. warnings .. " " or "")
                .. (infos > 0 and "I" .. infos .. " " or "")
                .. (hints > 0 and "H" .. hints .. " " or "")
            )
          end

          local lsp_format = function()
            local lsp =
              MiniStatusline.section_lsp({ trunc_width = 75, icon = "" })
            local clients = vim.trim(lsp):len()
            local buf_ft = vim.o.filetype

            if clients > 0 then
              return "[" .. vim.trim(lsp):len() .. "]" .. buf_ft
            end

            return buf_ft
          end

          local get_filesize = function()
            local size = vim.fn.getfsize(vim.fn.getreg("%"))

            if size <= 0 then
              return ""
            elseif size < 1024 then
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
                workspace_diagnostic(),
                vim.o.encoding,
                vim.o.fileformat,
                lsp_format(),
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

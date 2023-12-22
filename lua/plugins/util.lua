local utils = require("tm10ymhp.utils")

return {
  {
    "stevearc/conform.nvim",
    -- event = "BufWritePre",
    cmd = "ConformInfo",
    dependencies = { "williamboman/mason.nvim" },
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({
            lsp_fallback = false,
            async = false,
            timeout_ms = 1000
          })
        end,
        mode = { "n", "x" },
        desc = "Conform: Format"
      },
      {
        "<leader>uf",
        function()
          if vim.g.disable_autoformat then
            vim.g.disable_autoformat = false
            utils.notify("Autoformat enabled")
          else
            vim.g.disable_autoformat = true
            utils.notify("Autoformat disabled")
          end
        end,
        desc = "Toggle Format On Save"
      }
    },
    opts = {
      formatters_by_ft = {
        javascript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescript      = { "prettier" },
        typescriptreact = { "prettier" },
        vue             = { "prettier" },
        css             = { "prettier" },
        scss            = { "prettier" },
        less            = { "prettier" },
        html            = { "prettier" },
        json            = { "prettier" },
        jsonc           = { "prettier" },
        yaml            = { "prettier" },
        markdown        = { "prettier" },
        graphql         = { "prettier" },
        handlebars      = { "prettier" },
        astro           = { "prettier" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat then
          return
        end

        -- Disable autoformat for files in a certain path
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return
        end

        return {
          lsp_fallback = false,
          async = false,
          timeout_ms = 1000
        }
      end,
    }
  },
  {
    "mfussenegger/nvim-lint",
    dependencies = {
      "ahmedkhalf/project.nvim",
      "williamboman/mason.nvim",
    },
    keys = {
      {
        "<leader>cl",
        function() require("lint").try_lint() end,
        desc = "Lint",
      },
    },
    config = function()
      require("lint").linters_by_ft = {
        javascript      = { "eslint_d" },
        typescript      = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte          = { "eslint_d" },
      }

      vim.api.nvim_create_autocmd({
        "BufEnter",
        "BufWritePost",
        -- "InsertLeave",
        -- "TextChanged",
      }, {
          group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
          callback = function()
            require("lint").try_lint()
          end
        })

      require("lint").try_lint()
    end
  },
  {
    "telescope.nvim",
    dependencies = {
      {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        keys = {
          { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
        },
        opts = {
          -- silent_chdir = false,
        },
        config = function(_, opts)
          require("project_nvim").setup(opts)

          vim.cmd("ProjectRoot")

          pcall(require, 'notify')
          require("tm10ymhp.utils").notify("project.nvim loaded")

          vim.api.nvim_create_autocmd("User", {
            pattern = "LazyLoad",
            callback = function(event)
              if event.data == "telescope.nvim" then
                require("telescope").load_extension("projects")
              end
            end,
          })
        end
      },
    }
  },
  {
    "ojroques/nvim-osc52",
    keys = {
      {
        '<leader>y',
        function() require('osc52').copy_visual() end,
        mode = 'x'
      }
    },
    opts = {
      max_length = 0, --Maximum length of selection (0 for no limit)
      silent = false, --Disable message on successful copy
      trim = false,   --Trim text before copy
    },
    config = function(_, opts)
      -- Here is a non-exhaustive list of the status of popular terminal
      -- emulators regarding OSC52  (https://github.com/ojroques/vim-oscyank)
      --
      -- If you are using tmux, run these steps first: enabling OSC52 in tmux.
      -- Then make sure set-clipboard is set to on: set -s set-clipboard on.

      require('osc52').setup(opts)
    end
  },
  {
    "s1n7ax/nvim-window-picker",
    name = "window-picker",
    keys = {
      {
        "<leader>ww",
        function()
          local picked_window_id =
            require("window-picker").pick_window() or
            vim.api.nvim_get_current_win()

          vim.api.nvim_set_current_win(picked_window_id)
        end,
        desc = "Pick Window",
      }
    },
    opts = {
      hint = "statusline-winbar",
    },
    config = function(_, opts)
      require("window-picker").setup(opts)
    end
  },
  {
    "tpope/vim-sleuth",
    event = "VeryLazy",
    config = function()
      vim.cmd("silent Sleuth")
    end
  },
  {
    "chrisgrieser/nvim-various-textobjs",
    keys = function()
      local mappings = {
        {
          "ii",
          "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
          mode = { "o", "x" },
          desc = "inner-inner indentation textobj"
        },
        {
          "ai" ,
          "<cmd>lua require('various-textobjs').indentation('outer', 'inner')<CR>",
          mode = { "o", "x" },
          desc = "outer-inner indentation textobj"
        },
        {
          "iI" ,
          "<cmd>lua require('various-textobjs').indentation('inner', 'inner')<CR>",
          mode = { "o", "x" },
          desc = "inner-inner indentation textobj"
        },
        {
          "aI" ,
          "<cmd>lua require('various-textobjs').indentation('outer', 'outer')<CR>",
          mode = { "o", "x" },
          desc = "outer-outer indentation textobj"
        },
      }

      local innerOuterMaps = {
        number = "n",
        value = "v",
        key = "k",
        subword = "S", -- lowercase taken for sentence textobj
        closedFold = "z", -- z is the common prefix for folds
        chainMember = "m",
        htmlAttribute = "x",
        doubleSquareBrackets = "D",
        mdlink = "l",
        mdFencedCodeBlock = "C",
        pyTripleQuotes = "y",
      }

      for objName, map in pairs(innerOuterMaps) do
        local name = " " .. objName .. " textobj"
        table.insert(mappings, {
          "a" .. map,
          "<cmd>lua require('various-textobjs')." .. objName .. "('outer')<CR>",
          mode = { "o", "x" },
          desc = "outer" .. name
        })

        table.insert(mappings, {
          "i" .. map,
          "<cmd>lua require('various-textobjs')." .. objName .. "('inner')<CR>",
          mode = { "o", "x" },
          desc = "inner" .. name
        })
      end

      local oneMaps = {
        visibleInWindow = "gw",
        restOfIndentation = "R",
        restOfParagraph = "r",
        restOfWindow = "gW",
        column = "|",
        entireBuffer = "gG", -- G + gg
        url = "iu",
        multiCommentedLines = "ic"
      }

      for objName, map in pairs(oneMaps) do
        table.insert(mappings, {
          map,
          "<cmd>lua require('various-textobjs')." .. objName .. "()<CR>",
          mode = { "o", "x" },
          desc = objName .. " textobj"
        })
      end

      return mappings
    end,
    config = function()
      require("various-textobjs").setup({})
    end
  },
  {
    "echasnovski/mini.bracketed",
    keys = {
      { "]", mode = { "n", "x", "o" }, desc = "forward" },
      { "[", mode = { "n", "x", "o" }, desc = "backward" },
    },
    opts = {
      buffer     = { suffix = 'b', options = {} },
      comment    = { suffix = 'c', options = {} },
      conflict   = { suffix = 'x', options = {} },
      diagnostic = { suffix = 'e', options = {} },
      file       = { suffix = 'f', options = {} },
      indent     = { suffix = 'i', options = { change_type = 'diff'} },
      jump       = { suffix = 'j', options = {} },
      location   = { suffix = 'l', options = {} },
      oldfile    = { suffix = 'o', options = {} },
      quickfix   = { suffix = 'q', options = {} },
      treesitter = { suffix = 't', options = {} },
      undo       = { suffix = 'u', options = {} },
      window     = { suffix = 'w', options = {} },
      yank       = { suffix = 'y', options = {} },
    }
  },
  {
    "echasnovski/mini.align",
    keys = {
      { "ga", mode = { "n", "x" }, desc = "Align" },
      { "gA", mode = { "n", "x" }, desc = "Align with preview" },
    },
    config = true
  },
  {
    "echasnovski/mini.move",
    keys = {
      { "<M-k>", desc = "Move line up" },
      { "<M-j>", desc = "Move line down" },
      { "<M-h>", desc = "Move line left" },
      { "<M-l>", desc = "Move line right" },

      { "<M-k>", mode = "x", desc = "Move up" },
      { "<M-j>", mode = "x", desc = "Move down" },
      { "<M-h>", mode = "x", desc = "Move left" },
      { "<M-l>", mode = "x", desc = "Move right" },
    },
    config = true
  },
}

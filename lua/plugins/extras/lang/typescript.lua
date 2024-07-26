return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          init_options = {
            tsserver = {
              logVerbosity = "off",
              trace = "off",
              useSyntaxServer = "never",
            },
            preferences = {
              disableSuggestions = true,
              useLabelDetailsInCompletionEntries = false,
            },
          },
          settings = {
            typescript = {
              -- implementationsCodeLens = { enabled = true },
              -- referencesCodeLens = {
              --   enabled = true,
              --   showOnAllFunctions = true,
              -- },
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              -- implementationsCodeLens = { enabled = true },
              -- referencesCodeLens = {
              --   enabled = true,
              --   showOnAllFunctions = true,
              -- },
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "eslint_d" } },
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      -- stylua: ignore
      linters_by_ft = {
        javascript      = { "eslint_d" },
        typescript      = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte          = { "eslint_d" },
      },
      linters = {
        eslint_d = {
          condition = function()
            local old_eslint_config =
              vim.fn.split(vim.fn.glob(vim.uv.cwd() .. "/.eslintrc.*"))
            local new_eslint_config =
              vim.fn.split(vim.fn.glob(vim.uv.cwd() .. "/eslint.config.*"))
            local exists_eslint_config = not vim.tbl_isempty(
              vim.list_extend(old_eslint_config, new_eslint_config)
            )
            return exists_eslint_config
          end,
        },
      },
    },
  },
}

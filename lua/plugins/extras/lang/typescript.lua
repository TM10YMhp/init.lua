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
            local cwd = vim.uv.cwd()
            local old_eslint_config = function()
              return not vim.tbl_isempty(
                vim.fn.glob(cwd .. "/.eslintrc.*", true, true)
              )
            end
            local new_eslint_config = function()
              return not vim.tbl_isempty(
                vim.fn.glob(cwd .. "/eslint.config.*", true, true)
              )
            end
            return old_eslint_config() or new_eslint_config()
          end,
        },
      },
    },
  },
}

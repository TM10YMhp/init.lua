return {
  -- optional `vim.uv` typings
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "folke/lazydev.nvim",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        max_item_count = 40,
        group_index = 0,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "lua" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lua_ls = {
          on_new_config = function()
            require("lazy").load({
              plugins = { "lazydev.nvim" },
            })
          end,
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              telemetry = { enable = false },
              completion = {
                showWord = "Disable",
                workspaceWord = false,
              },
              hint = { enable = true },
              -- workspace = { checkThirdParty = "Disable" },
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "stylua" },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
      formatters = {
        stylua = {
          prepend_args = function()
            local cwd = vim.uv.cwd()
            if
              vim.fn.filereadable(cwd .. "/.stylua.toml") == 1
              or vim.fn.filereadable(cwd .. "/stylua.toml") == 1
            then
              return {}
            end

            return {
              "--config-path=" .. vim.fn.stdpath("config") .. "/.stylua.toml",
            }
          end,
        },
      },
    },
  },
}

-- TODO: wip

return {
  { import = "plugins.extras.lang.typescript" },
  { import = "plugins.extras.lang.css" },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "vue" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        volar = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.tsserver.filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
      }

      local vue_language_server_path = require("mason-registry")
        .get_package("vue-language-server")
        :get_install_path() .. "/node_modules/@vue/language-server"

      opts.servers.tsserver.init_options.plugins = opts.servers.tsserver.init_options.plugins
        or {}
      vim.list_extend(opts.servers.tsserver.init_options.plugins, {
        {
          name = "@vue/typescript-plugin",
          location = vue_language_server_path,
          languages = { "vue" },
        },
      })
    end,
  },
}

return {
  "neovim/nvim-lspconfig",
  -- event = "VeryLazy",
  cmd = { "LspLog", "LspStart", "LspInfo" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonLog" },
      opts = {
        ui = {
          check_outdated_packages_on_open = false,
          border = "single",
          width = 90,
          height = 40,
          icons = {
            package_installed = "●",
            package_pending = "-",
            package_uninstalled = "○"
          }
        }
      },
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = true
    },
    "b0o/SchemaStore.nvim",
    {
      "folke/neodev.nvim",
      opts = {},
    },
  },
  keys = {
    { 'K', vim.lsp.buf.hover, desc = 'LSP: Hover' },
    { '<c-k>', vim.lsp.buf.signature_help, desc = 'LSP: Signature Help' },
    { '<leader>ce', vim.diagnostic.open_float, desc = 'LSP: Line Diagnostics' },
    { '<leader>cf', vim.lsp.buf.format, desc = 'LSP: Format' },
    { '<leader>cr', vim.lsp.buf.rename, desc = 'LSP: Rename' },
    { '<leader>ca', vim.lsp.buf.code_action, desc = 'LSP: Code Action' },
    { '<leader>li', '<cmd>LspInfo<cr>', desc = 'LSP: Info' },
    { '<leader>ll', '<cmd>LspLog<cr>', desc = 'LSP: Log' },
    {
      '<leader>lwa',
      vim.lsp.buf.add_workspace_folder,
      desc = 'LSP: Add Workspace Folder',
    },
    {
      '<leader>lwr',
      vim.lsp.buf.remove_workspace_folder,
      desc = 'LSP: Remove Workspace Folder',
    },
    {
      '<leader>lwl',
      '<cmd>lua vim.print(vim.lsp.buf.list_workspace_folders())<cr>',
      desc = 'LSP: List Workspace Folders',
    },
    {
      '<leader>lr',
      function()
        require("tm10ymhp.utils").info('LSP: Restart')
        vim.diagnostic.reset()
        vim.cmd("LspRestart")
      end,
      desc = 'LSP: Restart',
    },
    {
      '<leader>lq',
      function()
        require("tm10ymhp.utils").info('LSP: Stop')
        vim.diagnostic.reset()
        vim.cmd("LspStop")
      end,
      desc = 'LSP: Stop',
    },
    {
      '<leader>ls',
      function()
        require("tm10ymhp.utils").info('LSP: Start')
        vim.cmd("LspStart")
      end,
      desc = 'LSP: Start',
    },
  },
  config = function()
    local lspconfig = require("lspconfig")

    require('lspconfig.ui.windows').default_options = {
      border = 'single',
    }

    local defaults = {
      autostart = false,
      on_attach = function(client, _)
        client.server_capabilities.semanticTokensProvider = nil
        client.server_capabilities.codeLensProvider = nil
        client.server_capabilities.colorProvider = nil
        client.server_capabilities.documentLinkProvider = nil
      end,
    }

    local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if has_cmp then
      defaults.capabilities = cmp_nvim_lsp.default_capabilities()
    end

    local dir = "servers"
    local config_path = vim.fn.stdpath("config") .. "/lua/"
    local files = vim.fn.split(vim.fn.glob(config_path .. dir .. "/*.lua", "\n"))

    for _, file in pairs(files) do
      local name_file = vim.fn.fnamemodify(file, ":t:r")
      local server = require(dir .. "." .. name_file)
      if type(server) == "table" then
        local enabled = not (server.enabled == false)
        if enabled then
          if type(server.setup) == "function" then
            local opts = server.setup()
            local setup = vim.tbl_deep_extend("force", defaults, opts)
            local name = server[1]
            lspconfig[name].setup(setup)
          else
            for _, name in ipairs(server) do
              if type(name) == "string" then lspconfig[name].setup(defaults) end
            end
          end
        end
      end
    end
  end
}

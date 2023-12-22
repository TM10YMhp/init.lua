local utils = require("tm10ymhp.utils")

return {
  "neovim/nvim-lspconfig",
  -- event = "VeryLazy",
  cmd = { "LspLog", "LspStart", "LspInfo" },
  dependencies = {
    {
      "j-hui/fidget.nvim",
      opts = {
        progress = {
          poll_rate = 2,
          display = {
            done_ttl = 0,
            progress_icon = {
              pattern = "dots_ellipsis", period = 2
            }
          },
        },
        notification = {
          poll_rate = 2,
          window = {
            winblend = 0,
            border = "single",
            align = "top",
            zindex = 150,
          },
        },
      },
    },
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
      function() vim.print(vim.lsp.buf.list_workspace_folders()) end,
      desc = 'LSP: List Workspace Folders',
    },
    {
      '<leader>lr',
      function()
        utils.notify('LSP: Restart')
        vim.diagnostic.reset()
        vim.cmd("LspRestart")
      end,
      desc = 'LSP: Restart',
    },
    {
      '<leader>lq',
      function()
        utils.notify('LSP: Stop')
        vim.diagnostic.reset()
        vim.cmd("LspStop")
      end,
      desc = 'LSP: Stop',
    },
    {
      '<leader>ls',
      function()
        utils.notify('LSP: Start')
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
      autostart = false
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
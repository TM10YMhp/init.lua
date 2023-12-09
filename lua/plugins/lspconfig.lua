local utils = require("tm10ymhp.utils")

return {
  "neovim/nvim-lspconfig",
  event = "VeryLazy",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {
      desc = 'LSP: Hover'
    })
    vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, {
      desc = 'LSP: Signature Help'
    })

    vim.keymap.set('n', '<leader>ce', vim.diagnostic.open_float, {
      desc = 'LSP: Line Diagnostics'
    })
    vim.keymap.set('n', '<leader>cf', vim.lsp.buf.format, {
      desc = 'LSP: Format'
    })
    vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, {
      desc = 'LSP: Rename'
    })
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {
      desc = 'LSP: Code Action'
    })

    vim.keymap.set('n', '<leader>lr', function()
      vim.diagnostic.reset()
      vim.cmd("LspRestart")
      utils.notify('LSP: Restart')
    end, { desc = 'LSP: Restart' })

    vim.keymap.set('n', '<leader>lq', function()
      vim.diagnostic.reset()
      vim.cmd("LspStop")
      utils.notify('LSP: Stop')
    end, { desc = 'LSP: Stop' })

    vim.keymap.set('n', '<leader>ls', function()
      vim.cmd("LspStart")
      utils.notify('LSP: Start')
    end, { desc = 'LSP: Start' })

    vim.keymap.set('n', '<leader>li', ':LspInfo<cr>', {
      desc = 'LSP: Info'
    })
    vim.keymap.set('n', '<leader>ll', ':LspLog<cr>', {
      desc = 'LSP: Log'
    })

    vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, {
      desc = 'LSP: Add Workspace Folder'
    })
    vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, {
      desc = 'LSP: Remove Workspace Folder'
    })
    vim.keymap.set('n', '<leader>lwl', function()
      vim.print(vim.lsp.buf.list_workspace_folders())
    end, { desc = 'LSP: List Workspace Folders'})

    require("lsp")
  end
}

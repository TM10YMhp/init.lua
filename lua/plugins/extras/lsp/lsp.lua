return {
  "neovim/nvim-lspconfig",
  cmd = { "LspLog", "LspLegacyStart", "LspStart" },
  init = function(plugin) require("lazy.core.loader").add_to_rtp(plugin) end,
  keys = {
    {
      "<c-k>",
      "<cmd>lua vim.lsp.buf.signature_help()<cr>",
      mode = { "n", "i", "s" },
      desc = "LSP: Signature Help",
    },
    {
      "K",
      "<cmd>lua vim.lsp.buf.hover()<cr>",
      desc = "LSP: Hover",
    },
    {
      "grf",
      "<cmd>lua vim.lsp.buf.format()<cr>",
      desc = "LSP: Format",
    },

    { "<leader>k", "", desc = "+workspace" },
    {
      "<leader>ka",
      "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",
      desc = "LSP: Add Workspace Folder",
    },
    {
      "<leader>kr",
      "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",
      desc = "LSP: Remove Workspace Folder",
    },
    {
      "<leader>kl",
      "<cmd>=vim.lsp.buf.list_workspace_folders()<cr>",
      desc = "LSP: List Workspace Folders",
    },

    { "<leader>l", "", desc = "+lsp/actions" },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP: Info" },
    {
      "<leader>ll",
      "<cmd>lua vim.cmd.edit(vim.lsp.log.get_filename())<cr>",
      desc = "LSP: Log",
    },
    { "<leader>lr", "<cmd>LspLegacyRestart<cr>", desc = "LSP: Restart" },
    { "<leader>lq", "<cmd>LspLegacyStop<cr>", desc = "LSP: Stop" },
    { "<leader>ls", "<cmd>LspLegacyStart<cr>", desc = "LSP: Start" },
  },
  config = function()
    vim.lsp.config("*", {
      capabilities = SereneNvim.lsp.get_capabilities(),
      flags = { debounce_text_changes = 500 },
    })

    -- https://github.com/neovim/nvim-lspconfig/pull/3890/files
    vim.api.nvim_create_user_command(
      "LspLegacyStart",
      function() SereneNvim.lsp.legacy_start() end,
      {}
    )
    vim.api.nvim_create_user_command(
      "LspLegacyStop",
      function() SereneNvim.lsp.legacy_stop() end,
      {}
    )
    vim.api.nvim_create_user_command(
      "LspLegacyRestart",
      function() SereneNvim.lsp.legacy_restart() end,
      {}
    )
  end,
}

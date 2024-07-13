return {
  "neovim/nvim-lspconfig",
  cmd = { "LspLog", "LspStart", "LspInfo" },
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonLog" },
      keys = { { "<leader>um", "<cmd>Mason<cr>", desc = "Mason" } },
      opts = {
        ui = {
          check_outdated_packages_on_open = false,
          border = "single",
          width = 90,
          height = 40,
          icons = {
            package_installed = "●",
            package_pending = "-",
            package_uninstalled = "○",
          },
        },
      },
      config = true,
    },
    { "williamboman/mason-lspconfig.nvim", config = true },
    { "b0o/SchemaStore.nvim" },
    { "deathbeam/lspecho.nvim", opts = { decay = 3000 } },
  },
  keys = {
    { "<leader>cr", vim.lsp.buf.rename, desc = "LSP: Rename" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "LSP: Code Action" },
    {
      "<c-k>",
      vim.lsp.buf.signature_help,
      mode = { "n", "i" },
      desc = "LSP: Signature Help",
    },
    {
      "K",
      function()
        -- NOTE: https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp.lua#L382-L383
        vim.lsp.buf.hover()
      end,
      desc = "LSP: Hover",
    },
    { "<leader>cf", vim.lsp.buf.format, desc = "LSP: Format" },
    {
      "<leader>ka",
      vim.lsp.buf.add_workspace_folder,
      desc = "LSP: Add Workspace Folder",
    },
    {
      "<leader>kr",
      vim.lsp.buf.remove_workspace_folder,
      desc = "LSP: Remove Workspace Folder",
    },
    {
      "<leader>kl",
      "<cmd>lua vim.print(vim.lsp.buf.list_workspace_folders())<cr>",
      desc = "LSP: List Workspace Folders",
    },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP: Info" },
    {
      "<leader>ll",
      "<cmd>edit " .. vim.lsp.get_log_path() .. "<cr>",
      desc = "LSP: Log",
    },
    {
      "<leader>lr",
      function()
        SereneNvim.info("LSP: Restart")
        vim.diagnostic.reset()
        vim.cmd("LspRestart")
      end,
      desc = "LSP: Restart",
    },
    {
      "<leader>lq",
      function()
        SereneNvim.info("LSP: Stop")
        vim.diagnostic.reset()
        vim.cmd("LspStop")
      end,
      desc = "LSP: Stop",
    },
    {
      "<leader>ls",
      function()
        SereneNvim.info("LSP: Start")
        vim.cmd("LspStart")
      end,
      desc = "LSP: Start",
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    require("lspconfig.ui.windows").default_options = { border = "single" }

    local dir = "servers"
    local config_path = vim.fn.stdpath("config") .. "/lua/"

    if vim.fn.isdirectory(config_path .. dir) == 0 then
      SereneNvim.error("LSP: '" .. dir .. "' folder not found")
      return
    end

    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      has_cmp and cmp_nvim_lsp.default_capabilities() or {}
    )
    local defaults = {
      autostart = false,
      flags = {
        allow_incremental_sync = false,
        debounce_text_changes = 500,
      },
      capabilities = capabilities,
    }

    local count = 0
    require("mason-lspconfig").setup_handlers({
      function(server_name)
        if server_name == "jdtls" or server_name == "biome" then
          return
        end

        local module_name = dir .. "." .. server_name
        local success, user_config = pcall(require, module_name)

        if not success then
          lspconfig[server_name].setup(defaults)
          return
        end

        if type(user_config) ~= "table" or vim.islist(user_config) then
          SereneNvim.error(
            string.format("LSP: '%s' should return a dictionary", module_name)
          )
          return
        end

        count = count + 1

        local config = vim.tbl_deep_extend("force", defaults, user_config)
        lspconfig[server_name].setup(config)
      end,
    })

    SereneNvim.info(
      string.format("LSP: using %d server configs found in '%s'", count, dir)
    )
  end,
}

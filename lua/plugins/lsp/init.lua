return {
  { import = "plugins.lsp.mason" },
  {
    "neovim/nvim-lspconfig",
    -- cmd = { "LspLog", "LspStart", "LspInfo" },
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
    },
    keys = {
      {
        "<leader>cr",
        "<cmd>lua vim.lsp.buf.rename()<cr>",
        desc = "LSP: Rename",
      },
      {
        "<leader>ca",
        "<cmd>lua vim.lsp.buf.code_action()<cr>",
        desc = "LSP: Code Action",
      },
      {
        "<c-k>",
        "<cmd>lua vim.lsp.buf.signature_help()<cr>",
        mode = { "n", "i" },
        desc = "LSP: Signature Help",
      },
      {
        "K",
        "<cmd>lua vim.lsp.buf.hover()<cr>",
        desc = "LSP: Hover",
      },
      {
        "<leader>cf",
        "<cmd>lua vim.lsp.buf.format()<cr>",
        desc = "LSP: Format",
      },
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
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP: Info" },
      {
        "<leader>ll",
        "<cmd>lua vim.cmd.edit(vim.lsp.get_log_path())<cr>",
        desc = "LSP: Log",
      },
      {
        "<leader>lr",
        function()
          SereneNvim.info("LSP: Restart")
          vim.cmd("LspRestart")
        end,
        desc = "LSP: Restart",
      },
      {
        "<leader>lq",
        function()
          SereneNvim.info("LSP: Stop")
          vim.cmd("LspStop")
        end,
        desc = "LSP: Stop",
      },
      {
        "<leader>ls",
        function()
          SereneNvim.info("LSP: Start LSP and Linter")
          SereneNvim.lint.enable()
          vim.cmd("LspStart")
        end,
        desc = "LSP: Start LSP and Linter",
      },
    },
    opts = {
      default_config = {
        autostart = false,
        flags = {
          allow_incremental_sync = false,
          debounce_text_changes = 500,
        },
      },
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
    },
    config = function(_, opts)
      require("lspconfig.ui.windows").default_options = { border = "single" }

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend(
          "force",
          opts.default_config or {},
          { capabilities = vim.deepcopy(capabilities) },
          servers[server] or {}
        )

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
          -- elseif opts.setup["*"] then
          --   if opts.setup["*"](server, server_opts) then
          --     return
          --   end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(
          require("mason-lspconfig.mappings.server").lspconfig_to_package
        )
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that
            -- cannot be installed with mason-lspconfig
            if
              server_opts.mason == false
              or not vim.tbl_contains(all_mslp_servers, server)
            then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup({
          ensure_installed = vim.tbl_deep_extend(
            "force",
            ensure_installed,
            SereneNvim.opts("mason-lspconfig.nvim").ensure_installed or {}
          ),
          handlers = { setup },
        })
      end
    end,
  },
}

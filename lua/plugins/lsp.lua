SereneNvim.on_lazy_init(function()
  vim.filetype.add({
    extension = {
      xaml = "xml",
    },
  })
end)

-- ts install xml and cs

return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    dependencies = { "williamboman/mason.nvim" },
  },
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
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspLog", "LspStart", "LspInfo" },
    dependencies = {
      "williamboman/mason.nvim",
      { "williamboman/mason-lspconfig.nvim", config = function() end },
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
        -- NOTE: https://github.com/neovim/neovim/blob/master/runtime/lua/vim/lsp.lua#L382-L383
        [[<cmd>lua vim.lsp.buf.hover()<cr>]],
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
    opts = {
      defaults = {
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
      servers = {
        lua_ls = {
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
      setup = {
        biome = function()
          return true
        end,
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
          opts.defaults or {},
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
          -- ensure_installed = vim.tbl_deep_extend(
          --   "force",
          --   ensure_installed,
          --   LazyVim.opts("mason-lspconfig.nvim").ensure_installed or {}
          -- ),
          ensure_installed = ensure_installed,
          handlers = { setup },
        })
      end
    end,
  },
}

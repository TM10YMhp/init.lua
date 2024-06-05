return {
  "neovim/nvim-lspconfig",
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
            package_uninstalled = "○",
          },
        },
      },
    },
    { "williamboman/mason-lspconfig.nvim", config = true },
    { "b0o/SchemaStore.nvim" },
    -- FIX: WIP Experimental
    {
      "folke/lazydev.nvim",
      dependencies = {
        "Bilal2453/luvit-meta", -- optional `vim.uv` typings
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
      },
      opts = {
        library = {
          -- Only load luvit types when the `vim.uv` word is found
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        },
      },
    },
    { "dmmulroy/ts-error-translator.nvim", opts = {} },
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
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP: Info" },
    {
      "<leader>ll",
      "<cmd>edit " .. vim.lsp.get_log_path() .. "<cr>",
      desc = "LSP: Log",
    },
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
    {
      "<leader>lr",
      function()
        require("tm10ymhp.utils").info("LSP: Restart")
        vim.diagnostic.reset()
        vim.cmd("LspRestart")
      end,
      desc = "LSP: Restart",
    },
    {
      "<leader>lq",
      function()
        require("tm10ymhp.utils").info("LSP: Stop")
        vim.diagnostic.reset()
        vim.cmd("LspStop")
      end,
      desc = "LSP: Stop",
    },
    {
      "<leader>ls",
      function()
        require("tm10ymhp.utils").info("LSP: Start")
        vim.cmd("LspStart")
      end,
      desc = "LSP: Start",
    },
  },
  config = function()
    local lspconfig = require("lspconfig")

    require("lspconfig.ui.windows").default_options = { border = "single" }

    local defaults = {
      autostart = false,
      flags = {
        allow_incremental_sync = false,
        debounce_text_changes = 500,
      },
    }

    local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if has_cmp then
      defaults.capabilities = cmp_nvim_lsp.default_capabilities()
    end

    local dir = "servers"
    local config_path = vim.fn.stdpath("config") .. "/lua/"
    local files =
      vim.fn.split(vim.fn.glob(config_path .. dir .. "/*.lua", true))

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
              if type(name) == "string" then
                lspconfig[name].setup(defaults)
              end
            end
          end
        end
      end
    end
  end,
}

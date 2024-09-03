SereneNvim.on_lazy_ft("nvim-jdtls", { "java" })

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "java" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- make sure mason installs the server
      servers = {
        jdtls = {},
      },
      setup = {
        jdtls = function()
          return true -- avoid duplicate servers
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>da",
        "<cmd>lua require'dap'.continue()<CR>",
        desc = "Debug: Start (JDTLS)",
      },
    },
  },
  {
    "mfussenegger/nvim-jdtls",
    opts = function()
      local jdtls_path =
        require("mason-registry").get_package("jdtls"):get_install_path()
      local lombok_jar = jdtls_path .. "/lombok.jar"
      local jar_path =
        vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

      -- TODO: check this
      local config_dir = "config_linux"
      if vim.fn.has("win32") == 1 then
        config_dir = "config_win"
      elseif vim.fn.has("mac") == 1 then
        config_dir = "config_mac"
      end
      local jdtls_config_dir = jdtls_path .. "/" .. config_dir
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_path = vim.fn.stdpath("data")
        .. "/.cache/jdtls/workspace/"
      local jdtls_workspace_dir = workspace_path .. project_name

      local root_files = {
        -- Multi-module projects
        {
          ".git",
          "mvnw",
          "gradlew",
          -- "build.gradle",
          -- "build.gradle.kts",
        },
        -- Single-module projects
        {
          "build.xml", -- Ant
          "pom.xml", -- Maven
          "settings.gradle", -- Gradle
          "settings.gradle.kts", -- Gradle
        },
      }

      return {
        -- stylua: ignore
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. lombok_jar,
          "-Xmx1G",
          "--add-modules=ALL-SYSTEM",
          "--add-opens", "java.base/java.util=ALL-UNNAMED",
          "--add-opens", "java.base/java.lang=ALL-UNNAMED",
          "-jar", jar_path,
          "-configuration", jdtls_config_dir,
          "-data", jdtls_workspace_dir,
        },
        root_dir = (function()
          for _, patterns in ipairs(root_files) do
            local root = require("jdtls.setup").find_root(patterns)
            if root then
              return root
            end
          end
        end)(),
        dap = { hotcodereplace = "auto" },
        jdtls = {
          settings = {
            java = {
              eclipse = { downloadSources = true },
              configuration = { updateBuildConfiguration = "interactive" },
              trace = { server = "off" },
              maven = { downloadSources = true },
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true },
              references = { includeDecompiledSources = true },
              signatureHelp = { enabled = true },
              format = { enabled = true },
            },
          },
          flags = {
            allow_incremental_sync = false,
            debounce_text_changes = 500,
          },
        },
      }
    end,
    config = function(_, opts)
      if vim.env.JAVA_HOME == nil then
        SereneNvim.warn("JDTLS: JAVA_HOME not found")
      end

      local mason_registry = require("mason-registry")
      local bundles = {} ---@type string[]
      if
        opts.dap
        and SereneNvim.has("nvim-dap")
        and mason_registry.is_installed("java-debug-adapter")
      then
        local java_dbg_path =
          mason_registry.get_package("java-debug-adapter"):get_install_path()
        local jar_patterns = {
          java_dbg_path
            .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        }

        for _, jar_pattern in ipairs(jar_patterns) do
          for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), "\n")) do
            table.insert(bundles, bundle)
          end
        end
      end

      local function attach_jdtls()
        local get_java_bufnrs = function()
          local res = {}
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if not vim.api.nvim_buf_is_loaded(bufnr) then
              goto continue
            end

            if
              vim.api.nvim_get_option_value("filetype", { buf = bufnr })
              == "java"
            then
              table.insert(res, bufnr)
            end

            ::continue::
          end

          return res
        end

        local jdtls = require("jdtls")
        local config = vim.tbl_deep_extend("force", {
          cmd = opts.cmd,
          root_dir = opts.root_dir,
          init_options = {
            bundles = bundles,
          },
          capabilities = SereneNvim.has("cmp-nvim-lsp") and require(
            "cmp_nvim_lsp"
          ).default_capabilities() or nil,
        }, opts.jdtls)

        if vim.g.my_jdtls_autostart then
          jdtls.start_or_attach(config)
        end

        vim.api.nvim_buf_create_user_command(0, "LspStart", function()
          if vim.g.my_jdtls_autostart then
            SereneNvim.warn("JDTLS: Already started")
            return
          end

          if vim.api.nvim_get_option_value("modified", {}) then
            SereneNvim.warn("JDTLS: Can't start on modified buffer")
            return
          end

          vim.g.my_jdtls_autostart = true

          local bufnrs = get_java_bufnrs()
          if #bufnrs == 0 then
            SereneNvim.info("JDTLS: No java files found")
            return
          end

          for _, bufnr in ipairs(bufnrs) do
            jdtls.start_or_attach(config, {}, {
              bufnr = bufnr,
            })
          end
          SereneNvim.info("JDTLS: started for " .. #bufnrs .. " java files")
        end, {})

        vim.api.nvim_buf_create_user_command(0, "LspStop", function()
          vim.g.my_jdtls_autostart = false
          vim.lsp.stop_client(vim.lsp.get_clients())
        end, {})

        vim.api.nvim_buf_create_user_command(0, "LspRestart", function()
          vim.cmd("JdtRestart")
        end, {})
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = attach_jdtls,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "jdtls" then
            if
              opts.dap
              and SereneNvim.has("nvim-dap")
              and mason_registry.is_installed("java-debug-adapter")
            then
              require("dap").configurations.java = {
                {
                  type = "java",
                  request = "attach",
                  name = "Debug (Attach) - Remote",
                  hostName = "127.0.0.1",
                  port = 5005,
                },
              }

              -- custom init for Java debugger
              require("jdtls").setup_dap(opts.dap)
              -- require("jdtls.dap").setup_dap_main_class_configs(opts.dap_main)
            end
          end
        end,
      })

      attach_jdtls()
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "google-java-format" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- TODO: like astro use internal formatter
        java = { "google-java-format" },
      },
    },
  },
}

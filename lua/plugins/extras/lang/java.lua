-- https://github.com/eclipse-jdtls/eclipse.jdt.ls/issues/581
-- https://github.com/eclipse-jdtls/eclipse.jdt.ls/issues/1714
-- https://nullprogram.com/blog/2011/08/30/
SereneNvim.on_lazy_ft("nvim-jdtls", { "java" })

SereneNvim.on_lazy_init(
  function()
    vim.filetype.add({
      filename = {
        ["build.xml"] = "xml",
      },
    })
  end
)

return {
  {
    "nvim-treesitter",
    opts = { ensure_installed = { "java" } },
  },
  {
    "mason-tool-installer.nvim",
    optional = true,
    opts = {
      ensure_installed = { "jdtls", "java-debug-adapter" },
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
    config = function()
      require("dap").configurations.java = {
        {
          type = "java",
          request = "attach",
          name = "Debug (Attach) - Port 9000",
          hostName = "127.0.0.1",
          port = 9000,
        },
      }
    end,
  },
  {
    "mfussenegger/nvim-jdtls",
    dependencies = { "nvim-lspconfig" },
    opts = function()
      local jdtls_path = vim.fn.expand("$MASON/packages/jdtls")
      local lombok_jar = jdtls_path .. "/lombok.jar"
      local jar_path = vim.fn.globpath(
        jdtls_path .. "/plugins",
        "org.eclipse.equinox.launcher_*.jar",
        true,
        true
      )[1]

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
          "-Xms1G",
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
            if root then return root end
          end
        end)(),
        dap = { hotcodereplace = "auto" },
        jdtls = {
          flags = { debounce_text_changes = 500 },
          settings = {
            -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/issues/1021
            -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Language-Server-Settings-&-Capabilities#java-compiler-options
            java = {
              settings = {
                url = vim.fn.expand(
                  vim.fn.stdpath("config") .. "/format/settings.pref"
                ),
              },
              compile = {
                nullAnalysis = {
                  mode = "automatic",
                  -- NOTE: do not modify, use settings.pref
                  nullable = {
                    "org.springframework.lang.Nullable",
                    "javax.annotation.Nullable",
                    "org.eclipse.jdt.annotation.Nullable",
                  },
                  nonnull = {
                    "org.springframework.lang.NonNull",
                    "javax.annotation.Nonnull",
                    "org.eclipse.jdt.annotation.NonNull",
                  },
                },
              },
              eclipse = { downloadSources = true },
              configuration = {
                updateBuildConfiguration = "automatic",
                -- runtimes = {
                --   {
                --     name = "JavaSE-17",
                --     path = vim.env.JAVA_HOME,
                --   },
                -- },
              },
              trace = { server = "off" },
              maven = { downloadSources = true },
              implementationsCodeLens = "all",
              referencesCodeLens = { enabled = true },
            },
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
          vim.fn.expand("$MASON/packages/java-debug-adapter")
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

      local no_autostart = function(config)
        if vim.g.my_jdtls_autostart then
          require("jdtls").start_or_attach(config, { dap = opts.dap })
        end

        vim.api.nvim_buf_create_user_command(0, "LspLegacyStart", function()
          local names = SereneNvim.lsp.legacy_start()
          if vim.tbl_contains(names, "jdtls") then return end

          local get_java_bufnrs = function()
            local res = {}
            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
              if not vim.api.nvim_buf_is_loaded(bufnr) then goto continue end

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

          if vim.g.my_jdtls_autostart then
            return SereneNvim.warn("JDTLS: Already started")
          end

          if vim.api.nvim_get_option_value("modified", {}) then
            return SereneNvim.warn("JDTLS: Can't start on modified buffer")
          end

          vim.g.my_jdtls_autostart = true

          local bufnrs = get_java_bufnrs()
          if #bufnrs == 0 then
            return SereneNvim.info("JDTLS: No java files found")
          end

          SereneNvim.info("JDTLS: started for " .. #bufnrs .. " java files")

          for _, bufnr in ipairs(bufnrs) do
            require("jdtls").start_or_attach(
              config,
              { dap = opts.dap },
              { bufnr = bufnr }
            )
          end
        end, {})

        vim.api.nvim_buf_create_user_command(0, "LspLegacyStop", function()
          vim.g.my_jdtls_autostart = false
          SereneNvim.lsp.legacy_stop()
        end, {})
      end

      local function attach_jdtls()
        local config = vim.tbl_deep_extend("force", {
          cmd = opts.cmd,
          root_dir = opts.root_dir,
          init_options = {
            bundles = bundles,
          },
          capabilities = SereneNvim.lsp.get_capabilities(),
        }, opts.jdtls)

        -- require("jdtls").start_or_attach(config, { dap = opts.dap })
        no_autostart(config)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "java" },
        callback = attach_jdtls,
      })

      attach_jdtls()
    end,
  },
}

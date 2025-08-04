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
    "google/styleguide",
    name = "java-google-styleguide",
    lazy = true,
  },
  {
    "mfussenegger/nvim-jdtls",
    opts = function()
      local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
      local workspace_dir = vim.fn.stdpath("data")
        .. "/site/java/workspace-root/"
        .. project_name
      vim.fn.mkdir(workspace_dir, "p")

      return {
        cmd = {
          "java",
          "-Declipse.application=org.eclipse.jdt.ls.core.id1",
          "-Dosgi.bundles.defaultStartLevel=4",
          "-Declipse.product=org.eclipse.jdt.ls.core.product",
          "-Dlog.protocol=true",
          "-Dlog.level=ALL",
          "-javaagent:" .. vim.fn.expand("$MASON/share/jdtls/lombok.jar"),
          "-Xms1g",
          "--add-modules=ALL-SYSTEM",
          "--add-opens",
          "java.base/java.util=ALL-UNNAMED",
          "--add-opens",
          "java.base/java.lang=ALL-UNNAMED",
          "-jar",
          vim.fn.expand(
            "$MASON/share/jdtls/plugins/org.eclipse.equinox.launcher.jar"
          ),
          "-configuration",
          vim.fn.expand("$MASON/share/jdtls/config"),
          "-data",
          workspace_dir,
        },
        root_dir = vim.fs.root(0, {
          {
            -- Multi-module projects
            ".git",
            "mvnw",
            "gradlew",
            -- "build.gradle",
            -- "build.gradle.kts",
          },
          {
            -- Single-module projects
            "build.xml", -- Ant
            "pom.xml", -- Maven
            "settings.gradle", -- Gradle
            "settings.gradle.kts", -- Gradle
          },
        }),
        dap = { hotcodereplace = "auto" },
        jdtls = {
          init_options = {
            bundles = {
              vim.fn.expand(
                "$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"
              ),
            },
          },
          -- handlers = {
          --   ["$/progress"] = function() end, -- disable progress updates.
          -- },
          filetypes = { "java" },
          flags = { debounce_text_changes = 500 },
          settings = {
            -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/issues/1021
            -- https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Language-Server-Settings-&-Capabilities#java-compiler-options
            java = {
              format = {
                enabled = true,
                settings = {
                  url = vim.fn.expand(
                    vim.fn.stdpath("data")
                      .. "/lazy/java-google-styleguide/eclipse-java-google-style.xml"
                  ),
                },
              },
              eclipse = { downloadSources = true },
              configuration = { updateBuildConfiguration = "interactive" },
              maven = { downloadSources = true },
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true },
              inlayHints = { parameterNames = { enabled = "all" } },
              signatureHelp = { enabled = true },
              completion = {
                favoriteStaticMembers = {
                  "org.hamcrest.MatcherAssert.assertThat",
                  "org.hamcrest.Matchers.*",
                  "org.hamcrest.CoreMatchers.*",
                  "org.junit.jupiter.api.Assertions.*",
                  "java.util.Objects.requireNonNull",
                  "java.util.Objects.requireNonNullElse",
                  "org.mockito.Mockito.*",
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
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
            },
          },
        },
      }
    end,
    config = function(_, _opts)
      if vim.env.JAVA_HOME == nil then
        SereneNvim.warn("JDTLS: JAVA_HOME not found")
      end

      local attach_jdtls = function(config, opts)
        if vim.g.sn_jdtls_autostart then
          require("jdtls").start_or_attach(config, opts)
        end

        vim.api.nvim_buf_create_user_command(0, "LspLegacyStart", function()
          if vim.tbl_contains(SereneNvim.lsp.legacy_start(), "jdtls") then
            return
          end

          local get_java_bufnrs = function()
            local bufnrs = {}
            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
              if
                vim.api.nvim_buf_is_loaded(bufnr)
                and vim.fn.buflisted(bufnr) == 1
                and vim.api.nvim_get_option_value("filetype", { buf = bufnr })
                  == "java"
              then
                bufnrs[#bufnrs + 1] = bufnr
              end
            end
            return bufnrs
          end

          if vim.g.sn_jdtls_autostart then
            return SereneNvim.warn("JDTLS: Already started")
          end

          vim.g.sn_jdtls_autostart = true

          local bufnrs = get_java_bufnrs()

          SereneNvim.info("JDTLS: started for " .. #bufnrs .. " java files")

          for _, bufnr in ipairs(bufnrs) do
            require("jdtls").start_or_attach(config, opts, { bufnr = bufnr })
          end
        end, {})

        vim.api.nvim_buf_create_user_command(0, "LspLegacyStop", function()
          vim.g.sn_jdtls_autostart = false
          SereneNvim.lsp.legacy_stop()
        end, {})

        vim.api.nvim_buf_create_user_command(
          0,
          "LspLegacyRestart",
          function() vim.cmd([[JdtRestart]]) end,
          {}
        )
      end

      local config = vim.tbl_deep_extend("force", {
        cmd = _opts.cmd,
        root_dir = _opts.root_dir,
        -- HACK: disable autopairs for java for lambda
        capabilities = SereneNvim.lsp.get_capabilities({
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = false,
              },
            },
          },
        }),
      }, _opts.jdtls)
      local opts = { dap = _opts.dap }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "java" },
        callback = function() attach_jdtls(config, opts) end,
      })

      attach_jdtls(config, opts)
    end,
  },
}

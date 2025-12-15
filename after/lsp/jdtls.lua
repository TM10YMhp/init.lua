-- TODO: check this
if not SereneNvim.is_loaded("nvim-jdtls") then
  return
end

if vim.env.JAVA_HOME == nil then
  SereneNvim.warn("JDTLS: JAVA_HOME not found")
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data")
  .. "/site/java/workspace-root/"
  .. project_name
vim.fn.mkdir(workspace_dir, "p")

require("jdtls.dap").setup_dap({ hotcodereplace = "auto" })

return {
  -- root_dir = vim.fs.root(0, {
  --   {
  --     -- Multi-module projects
  --     ".git",
  --     "mvnw",
  --     "gradlew",
  --     -- "build.gradle",
  --     -- "build.gradle.kts",
  --   },
  --   {
  --     -- Single-module projects
  --     "build.xml", -- Ant
  --     "pom.xml", -- Maven
  --     "settings.gradle", -- Gradle
  --     "settings.gradle.kts", -- Gradle
  --   },
  -- }),
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
  -- HACK: disable autopairs for java for lambda
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false,
        },
      },
    },
  },
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
      -- compile = {
      --   nullAnalysis = {
      --     mode = "automatic",
      --     -- NOTE: do not modify, use settings.pref
      --     nullable = {
      --       "org.springframework.lang.Nullable",
      --       "javax.annotation.Nullable",
      --       "org.eclipse.jdt.annotation.Nullable",
      --     },
      --     nonnull = {
      --       "org.springframework.lang.NonNull",
      --       "javax.annotation.Nonnull",
      --       "org.eclipse.jdt.annotation.NonNull",
      --     },
      --   },
      -- },
    },
  },
}

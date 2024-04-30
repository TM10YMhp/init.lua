local jdtls_path =
  require("mason-registry").get_package("jdtls"):get_install_path()
local workspace_path = vim.fn.stdpath("data") .. "/.cache/jdtls/workspace/"

local os = "linux"
if vim.fn.has("win32") == 1 then
  os = "win"
elseif vim.fn.has("mac") == 1 then
  os = "mac"
end

local path_to_lsp_server = jdtls_path .. "/config_" .. os
local path_jar =
  vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

return {
  "jdtls",
  setup = function()
    return {
      cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xmx1G",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        path_jar,
        "-configuration",
        path_to_lsp_server,
        "-data",
        workspace_dir,
      },
      root_dir = require("lspconfig").util.root_pattern(
        ".git",
        "mvnw",
        "gradlew",
        --
        "build.xml", -- Ant
        "pom.xml", -- Maven
        "settings.gradle", -- Gradle
        "settings.gradle.kts", -- Gradle
        -- Multi-module projects
        "build.gradle",
        "build.gradle.kts"
      ),
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
    }
  end,
}

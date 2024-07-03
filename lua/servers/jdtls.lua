local jdtls_path =
  require("mason-registry").get_package("jdtls"):get_install_path()

local jda_path =
  require("mason-registry").get_package("java-debug-adapter"):get_install_path()

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
local workspace_path = vim.fn.stdpath("data") .. "/.cache/jdtls/workspace/"
local workspace_dir = workspace_path .. project_name

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
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. jdtls_path .. "/lombok.jar",
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
  --- nvim-jdtls
  root_dir = (function()
    for _, patterns in ipairs(root_files) do
      local root = require("jdtls.setup").find_root(patterns)
      if root then
        return root
      end
    end
  end)(),
  --- lspconfig
  -- root_dir = function(fname)
  --   for _, patterns in ipairs(root_files) do
  --     local root = require("lspconfig").util.root_pattern(unpack(patterns))(fname)
  --     if root then
  --       return root
  --     end
  --   end
  -- end,
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
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
  init_options = {
    bundles = {
      vim.fn.glob(
        jda_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        true
      ),
    },
  },
  flags = {
    allow_incremental_sync = false,
    debounce_text_changes = 500,
  },
}

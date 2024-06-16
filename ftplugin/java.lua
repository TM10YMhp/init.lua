local jdtls = require("jdtls")
local jdtls_path =
  require("mason-registry").get_package("jdtls"):get_install_path()
local workspace_path = vim.fn.stdpath("data") .. "/.cache/jdtls/workspace/"

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
local root_dir = (function()
  for _, patterns in ipairs(root_files) do
    local root = require("jdtls.setup").find_root(patterns)
    if root then
      return root
    end
  end
end)()

local config = {
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
  root_dir = root_dir,
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
        1
      ),
    },
  },
}

local get_java_bufnrs = function()
  local res = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if not vim.api.nvim_buf_is_loaded(bufnr) then
      goto continue
    end

    local name = vim.api.nvim_buf_get_name(bufnr)
    local ext = name:match("^.+%.(.+)$")
    if ext == "java" then
      table.insert(res, bufnr)
    end

    ::continue::
  end

  return res
end

if vim.g.my_jdtls_autostart then
  jdtls.start_or_attach(config)
end

vim.api.nvim_buf_create_user_command(0, "LspStart", function()
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

local dap = require("dap")
dap.configurations.java = {
  {
    type = "java",
    request = "attach",
    name = "Debug (Attach) - Remote",
    hostName = "127.0.0.1",
    port = 5005,
  },
}

jdtls.setup_dap({ hotcodereplace = "auto" })

vim.keymap.set(
  "n",
  "<leader>da",
  "<cmd>lua require'dap'.continue()<CR>",
  { desc = "Debug: Start" }
)

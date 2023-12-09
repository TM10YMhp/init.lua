local jdtls_path = vim.fn.stdpath('data') .. "/mason/packages/jdtls"
local workspace_path = vim.fn.stdpath('data') .. '/.cache/jdtls/workspace/'

local os = "linux"
if vim.fn.has("win32") == 1 then
  os = "win"
elseif vim.fn.has("mac") == 1 then
  os = "mac"
end

local path_to_lsp_server = jdtls_path .. "/config_" .. os
local path_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

return {
  "jdtls",
  setup = function()
    return {
      cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1G',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        '-jar', path_jar,
        '-configuration', path_to_lsp_server,
        '-data', workspace_dir,
      },
      root_dir = require('lspconfig').util.root_pattern(
        ".git", "mvnw", "gradlew", "pom.xml", "build.gradle"
      ),
      settings = {
        java = {
          configuration = {
            updateBuildConfiguration = "disabled",
            maven = { userSettings = nil }
          },
          errors = { incompleteClasspath = { severity = "warning" } },
          trace = { server = "off" },
          import = {
            gradle = { enabled = true },
            maven = { enabled = true },
            exclusions = {
              "**/node_modules/**",
              "**/.metadata/**",
              "**/archetype-resources/**",
              "**/META-INF/maven/**",
              "/**/test/**"
            }
          },
          referencesCodeLens = { enabled = false },
          signatureHelp = { enabled = true },
          implementationsCodeLens = { enabled = false },
          format = { enabled = true },
          saveActions = { organizeImports = false },
          contentProvider = { preferred = nil },
          autobuild = { enabled = false },
        }
      }
    }
  end
}

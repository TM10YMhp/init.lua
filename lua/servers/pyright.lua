return {
  "pyright",
  setup = function()
    return {
      root_dir = require('lspconfig').util.root_pattern(
        ".git",
        "setup.py",
        "setup.cfg",
        "pyproject.toml",
        "requeriments.txt",
        "pyrightconfig.json"
      ),
      settings = {
        python = {
          analysis = {
            autoImportCompletions = true,
            autoSearchPaths = true,
            --diagnosticMode = "openFilesOnly",
            --typeCheckingMode = "off",
            useLibraryCodeForTypes = true,
          }
        }
      }
    }
  end
}

return {
  settings = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      usePlaceholders = false,
      staticcheck = true,
      directoryFilters = {
        "-**/.git",
        "-**/.vscode",
        "-**/.idea",
        "-**/.vscode-test",
        "-**/node_modules",
      },
    },
  },
}

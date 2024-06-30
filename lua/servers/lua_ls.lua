return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      telemetry = { enable = false },
      completion = {
        showWord = "Disable",
        workspaceWord = false,
      },
      hint = { enable = true },
      -- workspace = { checkThirdParty = "Disable" },
    },
  },
}

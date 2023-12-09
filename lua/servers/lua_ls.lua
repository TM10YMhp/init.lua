-- TODO: update neovim 0.9.1 to 0.10.0
-- https://github.com/neovim/neovim/pull/24592#issuecomment-1669604358
return {
  "lua_ls",
  setup = function()
    return {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          telemetry = { enable = false },
          completion = {
            showWord = "Disable",
            workspaceWord = false
          }
        }
      }
    }
  end
}

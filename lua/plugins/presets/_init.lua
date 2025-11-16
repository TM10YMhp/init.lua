if vim.env.USERNAME ~= "qwe" and vim.env.MY_PATH ~= "" then return end

return {
  { import = "plugins.presets.vscode" },
  { import = "plugins.presets.personal" },
  -- { import = "plugins.presets.phone" },
}

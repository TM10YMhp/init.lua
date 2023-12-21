local config_path = vim.fn.stdpath("config") .. "/lua/styles/"

-- cloak.nvim
vim.filetype.add({
  extension = {
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    -- INFO: Match filenames like - ".env.example", ".env.local" and so on
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})

-- markdown_preview.nvim
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 0
vim.g.mkdp_echo_preview_url = 1
vim.g.mkdp_refresh_slow = 1
vim.g.mkdp_preview_options = {
  disable_sync_scroll = 1
}
vim.g.mkdp_markdown_css = config_path .. "markdown.css"
vim.g.mkdp_highlight_css = config_path .. "highlight.css"
vim.g.mkdp_page_title = ' ${name} '
vim.g.mkdp_theme = 'dark'
vim.g.mkdp_combine_preview = 1
vim.g.mkdp_combine_preview_auto_refresh = 1

-- codeium.vim
vim.g.codeium_enabled = true
vim.g.codeium_disable_bindings = 1
vim.g.codeium_no_map_tap = true

-- vim-floaterm
vim.g.floaterm_width = 0.85
vim.g.floaterm_height = 0.85
vim.g.floaterm_autohide = 2

-- nvim-ts-context-commentstring
vim.g.skip_ts_context_commentstring_module = true

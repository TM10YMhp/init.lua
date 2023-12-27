-- tm10ymhp
vim.g.mapleader = ","

vim.g.netrw_fastbrowse = 0
vim.g.netrw_liststyle = 0
vim.g.netrw_mousemaps = 0
vim.g.netrw_winsize = 30

vim.g.matchparen_timeout = 20
vim.g.matchparen_insert_timeout = 20
vim.g.loaded_matchparen = 1

vim.g.loaded_matchit = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip       = 1

vim.g.markdown_recommended_style = 0

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

-- rest.nvim
vim.filetype.add({
  extension = {
    http = "http"
  }
})

-- markdown_preview.nvim
local config_path = vim.fn.stdpath("config") .. "/lua/styles/"

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

-- flog
vim.g.flog_default_opts = {
  max_count = 1000,
}

-- git-messenger
vim.g.git_messenger_floating_win_opts = {
  border = "single",
  row = 1,
  col = 1,
  style = "minimal",
  relative = "cursor",
}
vim.g.git_messenger_popup_content_margins = false
vim.g.git_messenger_no_default_mappings = true
vim.g.git_messenger_include_diff = "current"
vim.g.git_messenger_max_popup_width = 80
vim.g.git_messenger_max_popup_height = 40

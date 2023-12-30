vim.api.nvim_create_autocmd("FileType", {
  once = true,
  pattern = {
    "markdown",
  },
  callback = function()
    vim.defer_fn(function()
      require("lazy").load({
        plugins = { "markdown-preview.nvim" },
      })
    end, 1)
  end,
})

return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install && git restore .",
  init = function()
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
  end,
  keys = {
    {
      "<leader>up",
      vim.fn['mkdp#util#toggle_preview'],
      desc = "Toggle Markdown Preview",
    },
  }
}

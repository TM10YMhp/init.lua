return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install && git restore .",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  keys = {
    {
      "<leader>uP",
      vim.fn["mkdp#util#toggle_preview"],
      desc = "Toggle Markdown Preview",
    },
  },
  config = function()
    local config_path = vim.fn.stdpath("config") .. "/lua/styles/"

    vim.g.mkdp_command_for_global = true

    vim.g.mkdp_auto_start = false
    vim.g.mkdp_auto_close = false
    vim.g.mkdp_echo_preview_url = true
    vim.g.mkdp_refresh_slow = false
    vim.g.mkdp_preview_options = {
      disable_sync_scroll = true,
    }
    vim.g.mkdp_markdown_css = config_path .. "markdown.css"
    vim.g.mkdp_highlight_css = config_path .. "highlight.css"
    vim.g.mkdp_page_title = " ${name} "
    vim.g.mkdp_theme = "dark"
    vim.g.mkdp_combine_preview = true
    vim.g.mkdp_combine_preview_auto_refresh = true

    vim.api.nvim_exec_autocmds(
      "BufEnter",
      { group = "mkdp_init", modeline = false }
    )
  end,
}

return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install && git restore .",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  init = function()
    local config_path = vim.fn.stdpath("config") .. "/lua/styles/"

    vim.g.mkdp_command_for_global = 1

    vim.g.mkdp_auto_start = 0
    vim.g.mkdp_auto_close = 0
    vim.g.mkdp_echo_preview_url = 1
    vim.g.mkdp_refresh_slow = 1
    vim.g.mkdp_preview_options = {
      disable_sync_scroll = 1,
    }
    vim.g.mkdp_markdown_css = config_path .. "markdown.css"
    vim.g.mkdp_highlight_css = config_path .. "highlight.css"
    vim.g.mkdp_page_title = " ${name} "
    vim.g.mkdp_theme = "dark"
    vim.g.mkdp_combine_preview = 1
    vim.g.mkdp_combine_preview_auto_refresh = 1
  end,
  keys = {
    {
      "<leader>tp",
      vim.fn["mkdp#util#toggle_preview"],
      desc = "Toggle Markdown Preview",
    },
  },
  config = function()
    vim.cmd("doautocmd mkdp_init BufEnter")
  end,
}

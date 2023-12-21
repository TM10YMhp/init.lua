return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install && git restore .",
  ft = "markdown",
  keys = {
    { "<leader>up", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview" },
  },
}

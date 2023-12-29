return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install && git restore .",
  keys = {
    {
      "<leader>up",
      vim.fn['mkdp#util#toggle_preview'],
      desc = "Toggle Markdown Preview",
    },
  }
}

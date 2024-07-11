return {
  "echasnovski/mini.trailspace",
  event = vim.fn.argc(-1) == 0 and "BufAdd" or "VeryLazy",
  keys = {
    {
      "<leader>ct",
      function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
      end,
      desc = "Trim All",
    },
  },
  config = function()
    require("mini.trailspace").setup()

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "lazy", "floggraph", "dashboard" },
      callback = function(data)
        vim.b[data.buf].minitrailspace_disable = true
        vim.api.nvim_buf_call(data.buf, MiniTrailspace.unhighlight)
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function(ev)
        if vim.g.disable_autoformat or vim.b[ev.buf].disable_autoformat then
          return
        end

        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
      end,
    })
  end,
}
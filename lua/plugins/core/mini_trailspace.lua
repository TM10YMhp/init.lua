return {
  "echasnovski/mini.trailspace",
  event = "VeryLazy",
  keys = {
    {
      "<leader>ut",
      function()
        require("mini.trailspace").trim()
        require("mini.trailspace").trim_last_lines()
      end,
      desc = "Trim All",
    },
  },
  config = function()
    require("mini.trailspace").setup()

    local ft_ignore = {
      "lazy",
      "floggraph",
      "dashboard",
      "bigfile",
    }

    for _, bufnr in ipairs(vim.fn.tabpagebuflist(vim.fn.tabpagenr("$"))) do
      if vim.list_contains(ft_ignore, vim.bo[bufnr].filetype) then
        vim.b[bufnr].minitrailspace_disable = true
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = ft_ignore,
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

        require("mini.trailspace").trim()
        require("mini.trailspace").trim_last_lines()
      end,
    })
  end,
}

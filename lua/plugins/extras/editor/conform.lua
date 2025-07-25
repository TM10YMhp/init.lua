return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  init = function()
    SereneNvim.hacks.on_module("conform.health", function(mod)
      local show_window = mod.show_window
      mod.show_window = function()
        show_window()

        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_config(win, { border = "single" })
        vim.wo[win].wrap = true
      end
    end)

    SereneNvim.on_very_lazy(function()
      Snacks.toggle
        .new({
          name = "Format Buffer",
          get = function() return not vim.b.disable_autoformat end,
          set = function(state) vim.b.disable_autoformat = not state end,
        })
        :map("<leader>of")

      Snacks.toggle
        .new({
          name = "Format",
          get = function() return not vim.g.disable_autoformat end,
          set = function(state) vim.g.disable_autoformat = not state end,
        })
        :map("<leader>oF")
    end)
  end,
  keys = {
    {
      "<leader>cf",
      function() require("conform").format({ timeout_ms = 3000 }) end,
      desc = "Conform: Format",
    },
    {
      "<leader>cf",
      function()
        require("conform").format(
          { formatters = { "injected" }, timeout_ms = 5000 },
          function(err)
            if not err then
              local mode = vim.api.nvim_get_mode().mode
              if vim.startswith(string.lower(mode), "v") then
                vim.api.nvim_feedkeys(
                  vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                  "n",
                  true
                )
              end
            end
          end
        )
      end,
      mode = { "x" },
      desc = "Conform: Format Injected",
    },
  },
  opts = {
    default_format_opts = {
      lsp_format = "never",
      async = false,
      quiet = false,
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      -- Disable autoformat for files in a certain path
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match("/node_modules/") then return end

      return { timeout_ms = 500 }
    end,
  },
}

return {
  {
    'nvimdev/dashboard-nvim',
    event = function()
      local bufname = vim.api.nvim_buf_get_name(0)
      if bufname == "" then
        return { "VeryLazy" }
      end
    end,
    cmd = "Dashboard",
    opts = function()
      local logo = table.concat({
        "Welcome to my Neovim setup",
        "",
        "Inspired by the vision of Bram Moolenar",
        "the creator of Vim",
      }, "\n")

      logo = string.rep("\n", 6) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
          tabline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            { action = "Telescope find_files", desc = "Find file", key = "f" },
            { action = "ene | startinsert", desc = "New file", key = "n" },
            { action = "Telescope mru", desc = "Recent files", key = "o" },
            { action = "Telescope live_grep", desc = "Find text", key = "g" },
            { action = "Lazy", desc = "Lazy", key = "l" },
            { action = "qa", desc = "Quit", key = "q" },
            { action = "bd", desc = "Close", key = "d" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return {
              "",
              "lazy.nvim loaded "..stats.loaded.."/"..stats.count.." plugins in "..ms.."ms"
            }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 34 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
    config = function(_, opts)
      require('dashboard').setup(opts)
      vim.cmd('Dashboard')
      vim.b.minitrailspace_disable = true
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      opts.options.disabled_filetypes.winbar = vim.list_extend(
        opts.options.disabled_filetypes.winbar,
        { "dashboard" }
      )
    end,
  }
}

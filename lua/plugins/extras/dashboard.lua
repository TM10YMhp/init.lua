return {
  {
    "nvimdev/dashboard-nvim",
    event = function()
      local bufname = vim.api.nvim_buf_get_name(0)
      if bufname == "" then
        return { "VeryLazy" }
      end
    end,
    cmd = "Dashboard",
    dependencies = {
      "rubiin/fortune.nvim",
      opts = { max_width = 42 },
    },
    opts = function()
      local logo = table.concat({
        "Welcome to my Neovim setup",
        "",
        "Inspired by the vision of Bram Moolenar",
        "the creator of Vim",
      }, "\n")

      logo = string.rep("\n", 2) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          statusline = false,
          tabline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "Telescope find_files", desc = "Find file",    key = "f" },
            { action = "ene | startinsert",    desc = "New file",     key = "n" },
            { action = "Neotree",              desc = "Explorer",     key = "e" },
            { action = "Telescope mru",        desc = "Recent files", key = "o" },
            { action = "Telescope live_grep",  desc = "Find text",    key = "g" },
            { action = "Telescope projects",   desc = "Projects",     key = "p" },
            { action = "Lazy",                 desc = "Lazy",         key = "l" },
            { action = "qa",                   desc = "Quit",         key = "q" },
            { action = "bd",                   desc = "Close",        key = "d" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local fortune = require("fortune").get_fortune()
            local info = {
              "",
              "lazy.nvim loaded "
                .. stats.loaded
                .. "/"
                .. stats.count
                .. " plugins in "
                .. ms
                .. "ms",
              "",
            }
            return vim.list_extend(info, fortune)
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 34 - #button.desc)
        button.key_format = "  %s"
      end

      return opts
    end,
    config = function(_, opts)
      require("dashboard").setup(opts)

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" and vim.fn.argc(0) == 0 then
        vim.schedule(function()
          vim.cmd.close()
          vim.cmd("Dashboard")
          vim.b.minitrailspace_disable = true
          vim.defer_fn(function()
            require("lazy").show()
          end, 10)
        end)
      else
        vim.cmd("Dashboard")
        vim.b.minitrailspace_disable = true
      end
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    opts = function(_, opts)
      opts.options.disabled_filetypes.winbar =
        vim.list_extend(opts.options.disabled_filetypes.winbar, { "dashboard" })
    end,
  },
}

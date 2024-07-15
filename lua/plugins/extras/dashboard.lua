return {
  "nvimdev/dashboard-nvim",
  event = SereneNvim.lazy_init and "UIEnter" or {},
  cmd = "Dashboard",
  dependencies = {
    "rubiin/fortune.nvim",
    opts = { max_width = 42 },
  },
  opts = function()
    local logo = table.concat({
      "Welcome to my Neovim setup",
      "",
      "Inspired by the legacy of Bram Moolenaar",
      "the creator of Vim",
    }, "\n")

    logo = string.rep("\n", 2) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        statusline = false,
        tabline = false,
        winbar = false,
      },
      config = {
        header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = "ene | startinsert",    desc = "New file",     key = "<C-N>" },
            { action = "Telescope find_files", desc = "Find file",    key = "f" },
            { action = "Telescope live_grep",  desc = "Find text",    key = "g" },
            { action = "Neotree",              desc = "Explorer",     key = "e" },
            { action = "Telescope mru",        desc = "Recent files", key = "o" },
            { action = "Telescope projects",   desc = "Projects",     key = "p" },
            { action = "Mason",                desc = "Mason",        key = "m" },
            { action = "Lazy",                 desc = "Lazy",         key = "l" },
            { action = "bd",                   desc = "Close",        key = "d" },
            { action = "qa",                   desc = "Quit",         key = "q" },
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
    if vim.o.filetype == "lazy" and SereneNvim.lazy_init then
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
}

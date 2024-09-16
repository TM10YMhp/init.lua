return {
  "nvimdev/dashboard-nvim",
  event = SereneNvim.lazy_init and "VeryLazy" or {},
  cmd = "Dashboard",
  dependencies = {
    "rubiin/fortune.nvim",
    opts = { max_width = 42 },
  },
  opts = function()
    local logo = table.concat({
      "SereneNvim - indev " .. os.date("%y%m%d"),
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
            { action = "ene | startinsert",    desc = "New file",     key = "n" },
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

    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    -- only modify first instance
    local mod = require("dashboard")
    local instance = mod.instance
    mod.instance = function(self)
      instance(self)

      vim.opt.showtabline = 0

      vim.api.nvim_create_autocmd("BufUnload", {
        buffer = vim.api.nvim_get_current_buf(),
        once = true,
        callback = function()
          vim.opt.showtabline = 2
        end,
      })
    end

    vim.api.nvim_create_user_command("Dashboard", function()
      require("dashboard"):instance()

      vim.opt.showtabline = 0

      vim.api.nvim_create_autocmd("BufUnload", {
        buffer = vim.api.nvim_get_current_buf(),
        once = true,
        callback = function()
          vim.opt.showtabline = 2
        end,
      })
    end, {})

    vim.cmd("Dashboard")
  end,
}

local fzf_projects = function()
  local fzf_lua = require("fzf-lua")
  local history = require("project_nvim.utils.history")
  local results = history.get_recent_projects()
  local separator = require("fzf-lua.utils").nbsp

  local transform = function(value)
    return string.format(
      "%-28s%s%s",
      vim.fn.fnamemodify(value, ":t"),
      separator,
      value
    )
  end

  local normalize = function(value) return vim.split(value, separator)[2] end

  -- HACK:
  -- - displaying paths correctly on Windows
  -- - ignoring C: drive
  local contents = {}
  if SereneNvim.__IS_WINDOWS then
    for _, value in pairs(results) do
      value = value:gsub("/", "\\")
      value = value:sub(1, 1):upper() .. value:sub(2)
      if value ~= "C:" then table.insert(contents, transform(value)) end
    end
  end

  local opts = {
    fzf_opts = {
      ["--no-hscroll"] = true,
    },
    actions = {
      ["default"] = {
        function(selected)
          local cwd = normalize(selected[1])
          fzf_lua.files({ cwd = cwd })
        end,
      },
    },
  }

  fzf_lua.fzf_exec(contents, opts)
end
return {
  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    opts = {
      -- manual_mode = true,
      detection_methods = { "pattern" },
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        ".workspace", -- prefered for monorepos
      },
      -- silent_chdir = false,
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)

      vim.cmd("ProjectRoot")

      -- SereneNvim.on_load("telescope.nvim", function()
      --   require("telescope").load_extension("projects")
      -- end)
    end,
  },
  -- {
  --   "fzf-lua",
  --   optional = true,
  --   keys = {
  --     {
  --       "<leader>sp",
  --       function()
  --         fzf_projects()
  --       end,
  --       desc = "Fzf Projects",
  --     },
  --   },
  -- },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   optional = true,
  --   keys = {
  --     { "<leader>sp", "<cmd>Telescope projects<cr>", desc = "Projects" },
  --   },
  --   dependencies = { "ahmedkhalf/project.nvim" },
  -- },
  {
    "nvim-tree.lua",
    optional = true,
    dependencies = { "ahmedkhalf/project.nvim" },
  },
  {
    "neo-tree.nvim",
    optional = true,
    dependencies = { "ahmedkhalf/project.nvim" },
  },
  {
    "nvim-lint",
    optional = true,
    dependencies = { "ahmedkhalf/project.nvim" },
  },
}

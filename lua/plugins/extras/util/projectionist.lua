return {
  "tpope/vim-projectionist",
  -- event = "VeryLazy",
  keys = {
    { "<leader>ba", "<cmd>A<cr>", desc = "Alternate File" },
  },
  config = function()
    vim.g.projectionist_heuristics = {
      -- https://github.com/tpope/vim-projectionist/issues/55#issuecomment-894599469
      [".git/"] = {
        ["lua/plugins/*.lua"] = { alternate = "lua/util/{}.lua" },
        ["lua/plugins/core/*.lua"] = { alternate = "lua/util/{}.lua" },
        ["lua/util/*.lua"] = {
          alternate = {
            "lua/plugins/{}.lua",
            "lua/plugins/core/{}.lua",
          },
        },

        -- c
        ["*.c"] = {
          alternate = { "{}.h", "include/{basename}.h" },
          type = "source",
        },
        ["*.h"] = {
          alternate = { "{}.c", "src/{basename}.c" },
          type = "header",
        },
        ["*.cpp"] = {
          alternate = { "{}.hpp", "include/{basename}.hpp" },
          type = "source",
        },
        ["*.hpp"] = {
          alternate = { "{}.cpp", "src/{basename}.cpp" },
          type = "header",
        },

        -- laravel
        ["app/Http/Controllers/*Controller.php"] = {
          alternate = {
            "resources/views/{plural|snakecase}/index.blade.php",
          },
          type = "view",
        },
      },
    }

    vim.api.nvim_exec_autocmds(
      { "FileType" },
      { group = "projectionist", modeline = false }
    )
  end,
}

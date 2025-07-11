return {
  {
    "yegappan/mru",
    event = "VeryLazy",
    cmd = "MRU",
    config = function()
      vim.api.nvim_exec_autocmds(
        "BufRead",
        { group = "MRUAutoCmds", modeline = false }
      )
    end,
  },
  -- {
  --   "alan-w-255/telescope-mru.nvim",
  --   dependencies = { "yegappan/mru" },
  --   keys = {
  --     { "<leader>so", "<cmd>Telescope mru<cr>", desc = "MRU" },
  --   },
  --   config = function()
  --     require("telescope").load_extension("mru")
  --   end,
  -- },
  {
    "fzf-lua",
    optional = true,
    keys = {
      {
        "<leader>so",
        function()
          -- HACK: remove duplicate entries in windows
          local hash = {}
          local mrufiles = vim.fn["MruGetFiles"]()
          local entries = {}
          local cwd = vim.fn.getcwd()
          for _, v in ipairs(mrufiles) do
            if SereneNvim.__IS_WINDOWS then v = v:gsub("/", "\\") end
            if not hash[v] then
              local path = require("plenary.path"):new(v)
              if path:expand() ~= vim.api.nvim_buf_get_name(0) then
                table.insert(entries, path:make_relative(cwd))
              end

              hash[v] = true
            end
          end

          local opts = {
            fzf_opts = {
              ["--keep-right"] = true,
            },
            actions = {
              ["default"] = function(...)
                local actions = require("fzf-lua.actions")
                actions.file_edit_or_qf(...)
              end,
            },
            previewer = "builtin",
            winopts = {
              preview = { hidden = true },
            },
          }

          require("fzf-lua").fzf_exec(entries, opts)
        end,
        desc = "Fzf MRU",
      },
    },
  },
}

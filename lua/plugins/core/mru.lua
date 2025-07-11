return {
  {
    "wsdjeg/mru.nvim",
    event = "VeryLazy",
    config = function()
      require("mru").setup()

      vim.api.nvim_exec_autocmds(
        "BufEnter",
        { group = "mru.nvim", modeline = false }
      )
    end,
  },
  {
    "fzf-lua",
    optional = true,
    keys = {
      {
        "<leader>so",
        function()
          -- https://github.com/ibhagwan/fzf-lua/wiki/Advanced#lua-function-as-contents
          local content = coroutine.wrap(function(cb)
            local co = coroutine.running()

            local mrufiles = require("mru").get()
            local cwd = vim.fn.getcwd()
            local bufname = vim.api.nvim_buf_get_name(0)

            for _, v in ipairs(mrufiles) do
              -- plenary need "\\" as path separator in windows
              if SereneNvim.__IS_WINDOWS then v = v:gsub("/", "\\") end

              vim.schedule(function()
                local path = require("plenary.path"):new(v)
                -- remove current bufname
                if path:expand() ~= bufname then
                  local transform_path = path:make_relative(cwd)
                  if vim.env.USERPROFILE then
                    transform_path =
                      transform_path:gsub(vim.env.USERPROFILE, "~")
                  end
                  cb(transform_path, function() coroutine.resume(co) end)
                end
              end)
              coroutine.yield()
            end

            cb()
          end)

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

          require("fzf-lua").fzf_exec(content, opts)
        end,
      },
    },
  },
}

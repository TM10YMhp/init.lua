return {
  "ibhagwan/fzf-lua",
  optional = true,
  opts = function()
    -- https://github.com/ibhagwan/fzf-lua/issues/2063
    local toggle_flag = function(flag, desc)
      return {
        fn = function(_, opts)
          local actions = require("fzf-lua.actions")
          actions.toggle_flag(
            _,
            vim.tbl_extend("force", opts, { toggle_flag = flag })
          )
        end,
        header = function(opts)
          local utils = require("fzf-lua.utils")
          if opts.cmd and opts.cmd:match(utils.lua_regex_escape(flag)) then
            return "Remove " .. flag
          else
            return "Use " .. flag
          end
        end,
        desc = desc,
      }
    end

    return {
      { "hide" },
      fzf_colors = true,
      fzf_opts = {
        ["--no-scrollbar"] = true,
        ["--scroll-off"] = 8,
        ["--cycle"] = true,
        ["--info"] = "default",
        ["--highlight-line"] = false,
        -- ["--exact"] = true,
        -- ["--ansi"] = false,
      },
      defaults = {
        git_icons = false,
        file_icons = false,
        -- NOTE: formatters need `--ansi` option
        -- formatter = "path.filename_first",
        -- formatter = "path.dirname_first",
      },
      winopts = {
        treesitter = { enabled = false },
        border = "single",
        preview = {
          border = "single",
          delay = 200,
          vertical = "down:60%",
        },
      },
      previewers = {
        builtin = {
          extensions = {
            ["png"] = { "chafa", "{file}" },
            ["gif"] = { "chafa", "{file}" },
            ["webp"] = { "chafa", "{file}" },
            ["svg"] = { "chafa", "{file}" },
            ["jpg"] = { "chafa", "{file}" },
          },
          snacks_images = { enabled = false },
        },
      },
      files = {
        -- cmd = os.getenv("FZF_DEFAULT_COMMAND"),
        fzf_opts = {
          ["--tiebreak"] = "pathname,end",
          ["--keep-right"] = true,
        },
        winopts = { preview = { hidden = true } },
        actions = {
          ["alt-e"] = {
            fn = function(selected, opts)
              local tree = require("nvim-tree.api").tree
              local path = selected[1]
              tree.find_file({
                buf = path,
                open = true,
                focus = true,
              })
            end,
            header = function(opts) return "focus file" end,
            desc = "focus-file",
          },
        },
      },
      helptags = {
        fzf_opts = { ["--no-hscroll"] = true },
        winopts = { preview = { hidden = true } },
      },
      autocmds = {
        fzf_opts = { ["--no-hscroll"] = true },
      },
      keymaps = {
        modes = { "n", "i", "c", "v", "t", "o", "l" },
        fzf_opts = { ["--no-hscroll"] = true },
        winopts = { preview = { hidden = true } },
      },
      grep = {
        winopts = { preview = { hidden = true } },
        actions = {
          ["alt-s"] = toggle_flag("-F", "toggle-fixed-strings"),
          ["alt-w"] = toggle_flag("-w", "toggle-word-regexp"),
        },
      },
      lsp = {
        symbols = {
          cwd_only = true,
          symbol_style = 3,
          fzf_opts = { ["--no-hscroll"] = true },
        },
        code_actions = { previewer = "codeaction_native" },
      },
      -- https://github.com/ibhagwan/fzf-lua/discussions/1887
      diagnostics = { multiline = false },
      zoxide = {
        formatter = false,
        winopts = { preview = { hidden = true } },
        preview = (function()
          return vim.fn.executable("lsd") == 1
              and "lsd -la --color=always --group-directories-first --literal {2}"
            or vim.fn.executable("eza") == 1 and "eza -la --color=always --group-directories-first {2}"
            or "ls -la {2}"
        end)(),
        actions = {
          enter = function(selected, opts)
            local fzf_lua = require("fzf-lua")
            local actions = fzf_lua.actions

            actions.cd(selected, opts)
            fzf_lua.files({ cwd = cwd })
          end,
        },
      },
    }
  end,
}

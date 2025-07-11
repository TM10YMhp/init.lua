-- https://github.com/ibhagwan/fzf-lua/issues/2063
local t = function(flag, desc)
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
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  init = function()
    SereneNvim.on_very_lazy(function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "fzf-lua" } })
        -- local opts = LazyVim.opts("fzf-lua") or {}
        -- require("fzf-lua").register_ui_select(opts.ui_select or nil)
        require("fzf-lua").register_ui_select()
        return vim.ui.select(...)
      end
    end)
  end,
  keys = {
    {
      "<leader>xx",
      "<cmd>FzfLua diagnostics_document<cr>",
      desc = "Fzf Document Diagnostics",
    },
    {
      "<leader>xX",
      "<cmd>FzfLua diagnostics_workspace<cr>",
      desc = "Fzf Workspace Diagnostics",
    },
    {
      "<leader>xi",
      "<cmd>FzfLua lsp_implementations<cr>",
      desc = "Fzf Implementations",
    },
    {
      "<leader>xd",
      "<cmd>FzfLua lsp_definitions jump1=false<cr>",
      desc = "Fzf Definitions",
    },
    {
      "<leader>xD",
      "<cmd>FzfLua lsp_definitions<cr>",
      desc = "Fzf Definitions (Jump to single result)",
    },
    {
      "<leader>xt",
      "<cmd>FzfLua lsp_typedefs<cr>",
      desc = "Fzf Type Definitions",
    },
    {
      "<leader>xr",
      "<cmd>FzfLua lsp_references<cr>",
      desc = "Fzf References",
    },
    {
      "<leader>xs",
      "<cmd>FzfLua lsp_document_symbols<cr>",
      desc = "Fzf Symbols",
    },
    {
      "<leader>xS",
      "<cmd>FzfLua lsp_workspace_symbols<cr>",
      desc = "Fzf Symbols (workspace)",
    },
    {
      "<leader>xf",
      "<cmd>FzfLua lsp_finder<cr>",
      desc = "Fzf LSP Finder",
    },

    {
      "<leader>xR",
      function()
        local utils = require("fzf-lua.utils")
        local default_rg_opts = require("fzf-lua").defaults.grep.rg_opts

        require("fzf-lua").grep_cword({
          winopts = {
            preview = { hidden = false },
          },
          rg_opts = default_rg_opts:gsub(
            utils.lua_regex_escape(" --smart-case"),
            ""
          ),
        })
      end,
      desc = "Fzf Search Word",
    },

    {
      "<leader>xR",
      function()
        local utils = require("fzf-lua.utils")
        local default_rg_opts = require("fzf-lua").defaults.grep.rg_opts

        require("fzf-lua").grep_visual({
          winopts = {
            preview = { hidden = false },
          },
          rg_opts = default_rg_opts:gsub(
            utils.lua_regex_escape(" --smart-case"),
            ""
          ),
        })
      end,
      desc = "Fzf Search Word",
      mode = { "v" },
    },

    { "<leader>sw", "<cmd>FzfLua grep_curbuf<cr>", desc = "Fzf Search Word" },
    { "<leader>sc", "<cmd>FzfLua colorschemes<cr>", desc = "Fzf Colorschemes" },
    {
      "<leader>sL",
      function()
        local cwd = vim.fn.stdpath("data") .. "/" .. "lazy"
        require("fzf-lua").files({ cwd = cwd })
      end,
      desc = "Fzf Files (lazy)",
    },
    {
      "<leader>sl",
      function()
        local cwd = vim.fn.stdpath("config")
        require("fzf-lua").files({ cwd = cwd })
      end,
      desc = "Fzf Files (config)",
    },
    { "<leader>sf", "<cmd>FzfLua files<cr>", desc = "Fzf Files" },
    {
      "<leader>sF",
      function()
        local cwd = vim.fn.expand("%:p:h")

        if vim.o.filetype == "neo-tree" then
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/585
          local tree =
            require("neo-tree.sources.manager").get_state("filesystem").tree
          if tree ~= nil then
            local node = tree:get_node()
            cwd = vim.fn.fnamemodify(node.path, ":p:h")
          end
        end

        if vim.o.filetype == "oil" then
          local oil = require("oil")
          local entry = oil.get_cursor_entry()
          local dir = oil.get_current_dir()

          if entry and entry.type == "directory" then
            dir = dir .. entry.parsed_name
          end

          cwd = vim.fn.fnamemodify(dir, ":p:h")
        end

        if vim.o.filetype == "NvimTree" then
          local tree = require("nvim-tree.api").tree.get_node_under_cursor()
          if tree ~= nil then
            cwd = vim.fn.fnamemodify(tree.absolute_path, ":p:h")
          end
        end

        require("fzf-lua").files({ cwd = cwd })
      end,
      desc = "Fzf Files (cwd)",
    },
    { "<leader>sb", "<cmd>FzfLua buffers<cr>", desc = "Fzf Buffers" },
    {
      "<leader>se",
      "<cmd>FzfLua grep<cr>",
      desc = "Fzf Grep",
    },
    {
      "<leader>sg",
      "<cmd>FzfLua live_grep<cr>",
      desc = "Fzf Live Grep",
    },
    {
      "<leader>sG",
      function()
        local cwd = vim.fn.expand("%:p:h")

        if vim.o.filetype == "neo-tree" then
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/585
          local tree =
            require("neo-tree.sources.manager").get_state("filesystem").tree
          if tree ~= nil then
            local node = tree:get_node()
            cwd = vim.fn.fnamemodify(node.path, ":p:h")
          end
        end

        if vim.o.filetype == "oil" then
          local oil = require("oil")
          local entry = oil.get_cursor_entry()
          local dir = oil.get_current_dir()

          if entry and entry.type == "directory" then
            dir = dir .. entry.parsed_name
          end

          cwd = vim.fn.fnamemodify(dir, ":p:h")
        end

        if vim.o.filetype == "NvimTree" then
          local tree = require("nvim-tree.api").tree.get_node_under_cursor()
          if tree ~= nil then
            cwd = vim.fn.fnamemodify(tree.absolute_path, ":p:h")
          end
        end

        require("fzf-lua").live_grep({ cwd = cwd })
      end,
      desc = "Fzf Live Grep (cwd)",
    },
    { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Fzf Autocommands" },
    { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Fzf Commands" },
    { "<leader>sh", "<cmd>FzfLua helptags<cr>", desc = "Fzf Help Pages" },
    { "<leader>sr", "<cmd>FzfLua resume<cr>", desc = "Fzf Resume" },

    {
      "<leader>sk",
      "<cmd>FzfLua keymaps prompt=User\\ Keymaps>\\ <cr>",
      desc = "Fzf Keymaps <User>",
    },
    {
      "<leader>sK",
      "<cmd>FzfLua keymaps ignore_patterns=false<cr>",
      desc = "Fzf Keymaps",
    },
    {
      "<leader>sH",
      "<cmd>FzfLua highlights<cr>",
      desc = "Fzf Highlight Groups",
    },

    { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Fzf Git Commits" },
    { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Fzf Git Status" },
    { "<leader>gh", "<cmd>FzfLua git_hunks<CR>", desc = "Fzf Git Hunks" },
    { "<leader>gd", "<cmd>FzfLua git_diff<CR>", desc = "Fzf Git Diff" },

    { "<leader>sz", "<cmd>FzfLua zoxide<cr>", desc = "Fzf Zoxide" },
    {
      "<leader>sS",
      "<cmd>FzfLua spell_suggest<cr>",
      desc = "Fzf Spell Suggest",
    },
  },
  opts = {
    { "hide" },
    fzf_colors = true,
    fzf_opts = {
      ["--no-scrollbar"] = true,
      ["--scroll-off"] = 8,
      ["--cycle"] = true,
      ["--info"] = "default",
      ["--highlight-line"] = false,
      -- ["--exact"] = true,
    },
    defaults = {
      git_icons = false,
      file_icons = false,
      -- NOTE: formatters need `--ansi` option
      -- formatter = "path.filename_first",
      -- formatter = "path.dirname_first",
    },
    winopts = {
      border = "single",
      preview = {
        border = "single",
        delay = 200,
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
    keymaps = {
      modes = { "n", "i", "c", "v", "t", "o", "l" },
      fzf_opts = {
        ["--no-hscroll"] = true,
      },
      winopts = {
        preview = { hidden = true },
      },
    },
    files = {
      -- cmd = os.getenv("FZF_DEFAULT_COMMAND"),
      fzf_opts = {
        -- ["--ansi"] = false,
        ["--keep-right"] = true,
      },
      winopts = {
        preview = { hidden = true },
      },
    },
    helptags = {
      fzf_opts = {
        ["--no-hscroll"] = true,
      },
      winopts = {
        preview = { hidden = true },
      },
    },
    autocmds = {
      fzf_opts = {
        ["--no-hscroll"] = true,
      },
    },
    grep = {
      -- fzf_opts = { ["--ansi"] = false },
      -- NOTE: test pass args
      -- glob_separator = "%s\\\\",
      -- rg_glob_fn = function(query, opts)
      --   local regex, flags =
      --     query:match("^(.*)" .. opts.glob_separator .. "(.*)$")
      --   -- If no separator is detected will return the original query
      --   return (regex or query), flags
      -- end,
      winopts = {
        preview = { hidden = true },
      },
      actions = {
        ["alt-s"] = t("-F", "toggle-fixed-strings"),
        ["alt-w"] = t("-w", "toggle-word-regexp"),
        -- ["alt-s"] = {
        --   fn = function(_, opts)
        --     local actions = require("fzf-lua.actions")
        --     local flag = "-F"
        --     actions.toggle_flag(
        --       _,
        --       vim.tbl_extend("force", opts, { toggle_flag = flag })
        --     )
        --   end,
        --   header = function(o)
        --     local utils = require("fzf-lua.utils")
        --     local flag = "-F"
        --     if o.cmd and o.cmd:match(utils.lua_regex_escape(flag)) then
        --       return "Remove -F"
        --     else
        --       return "Use -F"
        --     end
        --   end,
        --   desc = "toggle-fixed-strings",
        -- },
        -- ["alt-w"] = {
        --   fn = function(_, opts)
        --     local actions = require("fzf-lua.actions")
        --     local flag = "-w"
        --     actions.toggle_flag(
        --       _,
        --       vim.tbl_extend("force", opts, { toggle_flag = flag })
        --     )
        --   end,
        --   header = function(o)
        --     local utils = require("fzf-lua.utils")
        --     local flag = "-w"
        --     if o.cmd and o.cmd:match(utils.lua_regex_escape(flag)) then
        --       return "Remove -w"
        --     else
        --       return "Use -w"
        --     end
        --   end,
        --   desc = "toggle-word-regexp",
        -- },
      },
    },
    git = {
      status = { preview_pager = false },
      commits = { preview_pager = false },
      bcommits = { preview_pager = false },
      blame = { preview_pager = false },
      diff = {
        winopts = { preview = { vertical = "down:60%" } },
      },
    },
    lsp = {
      symbols = {
        cwd_only = true,
        symbol_style = 3,
        fzf_opts = {
          ["--no-hscroll"] = true,
        },
      },
      -- code_actions = { previewer = "codeaction_native" },
    },
    highlights = {
      fzf_colors = {
        true,
        ["hl"] = "-1:reverse",
        ["hl+"] = "-1:reverse",
      },
    },
    -- https://github.com/ibhagwan/fzf-lua/discussions/1887
    diagnostics = { multiline = false },
    zoxide = {
      formatter = false,
      winopts = { preview = { hidden = true } },
      preview = "eza -la --color=always -g --group-directories-first {2}",
      actions = {
        enter = function(selected, opts)
          local fzf_lua = require("fzf-lua")
          local actions = fzf_lua.actions

          actions.cd(selected, opts)
          fzf_lua.files({ cwd = cwd })
        end,
      },
    },
  },
}

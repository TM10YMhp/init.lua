return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  init = function()
    SereneNvim.hacks.on_module("fzf-lua.utils", function(mod)
      local ansi_from_hl = mod.ansi_from_hl
      mod.ansi_from_hl = function(_hl, _s)
        local hl, s = ansi_from_hl(_hl, _s)
        return hl, s and s or ""
      end
    end)

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
    {
      "<leader>gf",
      "<cmd>FzfLua git_bcommits<CR>",
      desc = "Fzf Git Buffer Commits",
    },

    { "<leader>sz", "<cmd>FzfLua zoxide<cr>", desc = "Fzf Zoxide" },
    {
      "<leader>sS",
      "<cmd>FzfLua spell_suggest<cr>",
      desc = "Fzf Spell Suggest",
    },
  },
  opts = {},
}

return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      {
        "<leader>sw",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Search Word",
      },
      {
        "<leader>sc",
        "<cmd>Telescope colorscheme<cr>",
        desc = "Colorscheme",
        silent = true,
      },

      { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      {
        "<leader>sa",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "Find Files <All>",
            file_ignore_patterns = {},
            no_ignore = true,
          })
        end,
        desc = "Find Files <All>",
      },
      {
        "<leader>sF",
        "<cmd>Telescope find_files cwd=%:p:h<cr>",
        desc = "Find Files (cwd)",
      },
      { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      {
        "<leader>sA",
        "<cmd>Telescope autocommands<cr>",
        desc = "Autocommands",
      },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>sk",
        function()
          require("telescope.builtin").keymaps({
            prompt_title = "Key Maps <User>",
            show_plug = false,
          })
        end,
        desc = "Key Maps <User>",
      },
      {
        "<leader>sK",
        "<cmd>Telescope keymaps<cr>",
        desc = "Key Maps",
      },
      {
        "<leader>sH",
        "<cmd>Telescope highlights<cr>",
        desc = "Search Highlight Groups",
      },

      {
        "<leader>cd",
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        desc = "Document Diagnostics",
      },
      {
        "<leader>cD",
        "<cmd>Telescope diagnostics<cr>",
        desc = "Workspace Diagnostics",
      },

      {
        "<leader>sd",
        "<cmd>Telescope lsp_definitions<cr>",
        desc = "LSP: Goto Definitions",
      },
      {
        "<leader>si",
        "<cmd>Telescope lsp_implementations<cr>",
        desc = "LSP: Goto Implementations",
      },
      {
        "<leader>sD",
        "<cmd>Telescope lsp_type_definitions<cr>",
        desc = "LSP: Goto Type Definitions",
      },
      {
        "<leader>sr",
        "<cmd>Telescope lsp_references<cr>",
        desc = "LSP: Goto References",
      },
      {
        "<leader>ss",
        "<cmd>Telescope lsp_document_symbols<cr>",
        desc = "LSP: Goto Symbols",
      },
      {
        "<leader>sS",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "LSP: Goto Symbols (workspace)",
      },

      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Git Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Git Status" },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")
      local action_layout = require("telescope.actions.layout")

      -- https://github.com/gabsdotco/init.lua/blob/136435ceb8ef85ada27f1be2b0041954a10cabd6/lua/plugins/telescope.lua#L15
      local layout_strategies = require("telescope.pickers.layout_strategies")
      layout_strategies.vertical_fused = function(
        picker,
        max_columns,
        max_lines,
        layout_config
      )
        local layout = layout_strategies.vertical(
          picker,
          max_columns,
          max_lines,
          layout_config
        )

        layout.results.title = ""

        if layout.preview then
          layout.preview.title = ""
          layout.results.height = layout.results.height + 1
          layout.preview.line = layout.results.line + layout.results.height + 1
          layout.preview.borderchars =
            { "─", "│", "─", "│", "├", "┤", "┘", "└" }
        else
          layout.results.borderchars =
            { "─", "│", "─", "│", "├", "┤", "┘", "└" }
        end

        layout.prompt.line = layout.results.line - 2

        return layout
      end

      return vim.tbl_deep_extend("force", opts, {
        defaults = {
          preview = {
            hide_on_startup = true,
            filetype_hook = function(filepath, bufnr, _opts)
              if SereneNvim.is_bigfile(filepath) then
                require("telescope.previewers.utils").set_preview_message(
                  bufnr,
                  _opts.winid,
                  string.format(
                    "File too long (%s bytes)",
                    vim.fn.getfsize(filepath)
                  )
                )
                return false
              end

              return true
            end,
          },
          -- hl_result_eol = false,
          dynamic_preview_title = true,
          prompt_prefix = "",
          color_devicons = false,
          file_ignore_patterns = {
            "build/",
            ".cache/",
            ".git/",
            "node_modules/",
            "__pycache__/",
            ".class$",
          },
          border = true,
          -- stylua: ignore
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          layout_strategy = "vertical_fused",
          sorting_strategy = "ascending",
          path_display = { truncate = true },
          layout_config = {
            width = { 0.7, min = 90 },
            height = 40,
            preview_cutoff = 0,
            prompt_position = "top",
            horizontal = {
              preview_width = 0.65,
            },
            vertical = {
              preview_height = 0.65,
              mirror = true,
            },
          },
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--hidden",
            "--trim",
            "--fixed-strings",
            -- windows path separator
            "--path-separator",
            "/",
          },
          mappings = {
            i = {
              ["<C-p>"] = action_layout.toggle_preview,
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<M-q>"] = SereneNvim.telescope.open_all,
              ["<CR>"] = SereneNvim.telescope.open_selected,
              --
              ["<PageUp>"] = false,
              ["<PageDown>"] = false,
              ["<M-u>"] = actions.results_scrolling_up,
              ["<M-d>"] = actions.results_scrolling_down,
            },
            n = {
              ["<C-p>"] = action_layout.toggle_preview,
              ["<M-q>"] = SereneNvim.telescope.open_all,
              ["<CR>"] = SereneNvim.telescope.open_selected,
              --
              ["<PageUp>"] = false,
              ["<PageDown>"] = false,
              ["q"] = actions.close,
              ["<M-u>"] = actions.results_scrolling_up,
              ["<M-d>"] = actions.results_scrolling_down,
            },
          },
          history = {
            limit = 100,
            cycle_wrap = true,
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            -- windows path separator
            find_command = {
              "rg",
              "--files",
              "--path-separator",
              "/",
            },
          },
          buffers = {
            path_display = {
              truncate = true,
              filename_first = {
                reverse_directories = true,
              },
            },
          },
          diagnostics = {
            preview = { hide_on_startup = false },
            sort_by = "severity",
          },
          lsp_definitions = {
            preview = { hide_on_startup = false },
            jump_type = "never",
            show_line = false,
          },
          lsp_implementations = {
            preview = { hide_on_startup = false },
            jump_type = "never",
            show_line = false,
          },
          lsp_references = {
            jump_type = "never",
            show_line = false,
            include_declarations = false,
          },
          lsp_type_definitions = {
            preview = { hide_on_startup = false },
            jump_type = "never",
            show_line = false,
          },
          colorscheme = {
            layout_strategy = "bottom_pane",
            preview = { hide_on_startup = true },
            theme = "ivy",
            borderchars = {
              -- stylua: ignore
              preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            },
            enable_preview = true,
            results_title = false,
          },
          git_commits = { preview = { hide_on_startup = false } },
          git_status = { preview = { hide_on_startup = false } },
          git_branches = { preview = { hide_on_startup = false } },
          git_bcommits = { preview = { hide_on_startup = false } },
          git_files = { preview = { hide_on_startup = false } },
          git_stash = { preview = { hide_on_startup = false } },
          keymaps = {
            modes = { "", "n", "v", "s", "x", "o", "!", "i", "l", "c", "t" },
            layout_config = { width = 80 },
          },
          current_buffer_fuzzy_find = {
            skip_empty_lines = true,
            tiebreak = function(current_entry, existing_entry)
              -- returning true means preferring current entry
              return current_entry.lnum < existing_entry.lnum
            end,
          },
        },
      })
    end,
  },
  -- integrate telescope with neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      commands = {
        telescope_find = function(state)
          if state.tree == nil then
            return
          end
          local node = state.tree:get_node()
          local path = node:get_id()
          if vim.fn.isdirectory(path) == 0 then
            path = node._parent_id
          end
          SereneNvim.telescope.get_telescope_builtin("find_files", state, path)
        end,
        telescope_find_root = function(state)
          if state.tree == nil then
            return
          end
          local path = state.tree.nodes.root_ids[1]
          SereneNvim.telescope.get_telescope_builtin("find_files", state, path)
        end,
        telescope_grep = function(state)
          if state.tree == nil then
            return
          end
          local node = state.tree:get_node()
          local path = node:get_id()
          if vim.fn.isdirectory(path) == 0 then
            path = node._parent_id
          end
          SereneNvim.telescope.get_telescope_builtin("live_grep", state, path)
        end,
        telescope_grep_root = function(state)
          if state.tree == nil then
            return
          end
          local path = state.tree.nodes.root_ids[1]
          SereneNvim.telescope.get_telescope_builtin("live_grep", state, path)
        end,
      },
      filesystem = {
        window = {
          mappings = {
            ["F"] = "telescope_find",
            ["f"] = "telescope_find_root",
            ["G"] = "telescope_grep",
            ["g"] = "telescope_grep_root",
          },
        },
      },
    },
  },
}

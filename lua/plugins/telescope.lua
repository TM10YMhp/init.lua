return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>sw",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Search Word",
      },
      {
        "<leader>sc",
        ":Telescope colorscheme<cr>",
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
            filter = function(km)
              if
                string.match(tostring(km.lhs), "Þ")
                or string.match(tostring(km.rhs), "which%-key")
              then
                return false
              end
              return true
            end,
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
    opts = function()
      local actions = require("telescope.actions")
      local action_layout = require("telescope.actions.layout")

      -- https://github.com/nvim-telescope/telescope.nvim/issues/1048
      local open_selected = function(prompt_bufnr)
        local picker =
          require("telescope.actions.state").get_current_picker(prompt_bufnr)
        local selected = picker:get_multi_selection()
        if vim.tbl_isempty(selected) then
          actions.select_default(prompt_bufnr)
        else
          actions.close(prompt_bufnr)
          for _, v in pairs(selected) do
            if v.path then
              vim.cmd(
                "edit"
                  .. (v.lnum and " +" .. v.lnum or "")
                  .. " "
                  .. v.path:gsub("/", "\\")
              )
            end
          end
        end
      end

      local open_all = function(prompt_bufnr)
        local picker =
          require("telescope.actions.state").get_current_picker(prompt_bufnr)

        local manager = picker.manager
        if manager:num_results() > 15 then
          SereneNvim.warn("Too many results, limiting to 15")
          return
        end

        local entries = {}
        local entry_to_path = function(entry)
          local text = entry.text
          if not text then
            if type(entry.value) == "table" then
              text = entry.value.text
            else
              text = entry.value
            end
          end

          return text
        end
        for entry in manager:iter() do
          table.insert(entries, entry_to_path(entry))
        end

        if vim.tbl_isempty(entries) then
          SereneNvim.warn("No results")
        else
          actions.close(prompt_bufnr)
          for _, v in pairs(entries) do
            vim.cmd("edit" .. " " .. v:gsub("/", "\\"))
          end
        end
      end

      return {
        defaults = {
          preview = {
            hide_on_startup = true,
            filetype_hook = function(filepath, bufnr, opts)
              if SereneNvim.is_large_file(filepath) then
                require("telescope.previewers.utils").set_preview_message(
                  bufnr,
                  opts.winid,
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
            "build\\",
            ".cache/",
            ".cache\\",
            ".git/",
            ".git\\",
            "node_modules/",
            "node_modules\\",
            "__pycache__/",
            "__pycache__\\",
            ".class$",
          },
          border = true,
          -- stylua: ignore
          borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
          layout_strategy = "vertical",
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
              ["<M-q>"] = open_all,
              ["<CR>"] = open_selected,
              --
              ["<PageUp>"] = false,
              ["<PageDown>"] = false,
              ["<M-u>"] = actions.results_scrolling_up,
              ["<M-d>"] = actions.results_scrolling_down,
            },
            n = {
              ["<C-p>"] = action_layout.toggle_preview,
              ["<M-q>"] = open_all,
              ["<CR>"] = open_selected,
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
            path_display = { tail = true },
            preview = { hide_on_startup = false },
            sort_by = "severity",
          },
          lsp_definitions = {
            path_display = { tail = true },
            preview = { hide_on_startup = false },
            jump_type = "never",
            show_line = false,
          },
          lsp_implementations = {
            path_display = { tail = true },
            preview = { hide_on_startup = false },
            jump_type = "never",
            show_line = false,
          },
          lsp_references = {
            path_display = { tail = true },
            preview = { hide_on_startup = false },
            jump_type = "never",
            show_line = false,
            include_declarations = false,
          },
          lsp_type_definitions = {
            path_display = { tail = true },
            preview = { hide_on_startup = false },
            jump_type = "never",
            show_line = false,
          },
          lsp_dynamic_workspace_symbols = {
            path_display = { tail = true },
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
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    opts = {
      extensions = {
        fzf = {
          fuzzy = false,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
    end,
  },
}

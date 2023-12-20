return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ef", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      {
        "<leader>eF",
        "<cmd>Telescope find_files cwd=%:p:h<cr>",
        desc = "Find Files (cwd)",
      },
      { "<leader>eb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>elg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>ea", "<cmd>Telescope autocommands<cr>", desc = "Autocommands" },
      { "<leader>ec", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>eh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>er", "<cmd>Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>ek",
        "<cmd>Telescope keymaps show_plug=false<cr>",
        desc = "Key Maps",
      },

      {
        "<leader>/",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Search Word",
      },
      { "<leader>uc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme with preview" },
      { "<leader>uh", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },

      { "<leader>cD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>cd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>cgd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definitions" },
      { "<leader>cgt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definitions" },
      { "<leader>cgr", "<cmd>Telescope lsp_references<cr>", desc = "Goto References" },
      { "<leader>cgs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Goto Symbols" },
      { "<leader>cgS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Goto Symbols (workspace)" },
    },
    opts = function()
      local actions = require("telescope.actions")
      local action_layout = require("telescope.actions.layout")
      local action_state = require("telescope.actions.state")

      local open_selected = function(pb)
        -- https://github.com/nvim-telescope/telescope.nvim/issues/1048
        local picker = action_state.get_current_picker(pb)
        local multi = picker:get_multi_selection()
        actions.select_default(pb) -- the normal enter behaviour
        for _, j in pairs(multi) do
          if j.path ~= nil then -- is it a file -> open it as well:
            vim.cmd(string.format("%s %s", "edit", j.path))
          end
        end
      end

      return {
        defaults = {
          preview = {
            hide_on_startup = true,
            filetype_hook = function(filepath, bufnr, opts)
              if require('tm10ymhp.utils').is_large_file(filepath) then
                require("telescope.previewers.utils").set_preview_message(
                  bufnr,
                  opts.winid,
                  string.format("File too long (%s bytes)",
                  vim.fn.getfsize(filepath))
                )
                return false
              end

              return true
            end,
          },
          hl_result_eol = false,
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
              preview_width = 0.6,
            },
            vertical = {
              preview_height = 0.6,
              mirror = true
            }
          },
          vimgrep_arguments = {
            "rg", "--color=never", "--no-heading", "--with-filename",
            "--line-number", "--column", "--hidden",
            "--trim"
          },
          mappings = {
            i = {
              ["<C-p>"] = action_layout.toggle_preview,
              ["<M-q>"] = open_selected
            },
            n = {
              ["<C-p>"] = action_layout.toggle_preview,
              ["<M-q>"] = open_selected
            }
          },
        },
        pickers = {
          find_files = { hidden = true },
          diagnostics = {
            path_display = { tail = true },
            preview = { hide_on_startup = false },
            sort_by = "severity"
          },
          lsp_definitions = {
            path_display = { tail = true },
            preview = { hide_on_startup = false },
            jump_type = 'never',
            show_line = false,
          },
          lsp_references = {
            path_display = { tail = true },
            preview = { hide_on_startup = false },
            jump_type = 'never',
            show_line = false,
          },
          lsp_type_definitions = {
            path_display = { tail = true },
            preview = { hide_on_startup = false },
            jump_type = 'never',
            show_line = false,
          },
          lsp_dynamic_workspace_symbols = {
            path_display = { tail = true }
          },
          colorscheme = {
            layout_strategy = 'horizontal',
            enable_preview = true
          },
          git_commits = { preview = { hide_on_startup = false } },
          git_status = { preview = { hide_on_startup = false } },
          git_branches = { preview = { hide_on_startup = false } },
          git_bcommits = { preview = { hide_on_startup = false } },
          git_files = { preview = { hide_on_startup = false } },
          git_stash = { preview = { hide_on_startup = false } },
          keymaps = {
            modes = { "", "n", "v", "s", "x", "o", "!", "i", "l", "c", "t" },
            layout_config = { width = 80 }
          },
          current_buffer_fuzzy_find = {
            skip_empty_lines = true
          }
        },
        extensions = {
          fzf = {
            fuzzy = false,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
          },
          undo = { use_delta = false },
        }
      }
    end,
  },
}

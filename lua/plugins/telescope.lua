return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      {
        "<leader>sF",
        "<cmd>Telescope find_files cwd=%:p:h<cr>",
        desc = "Find Files (cwd)",
      },
      { "<leader>sb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Autocommands" },
      { "<leader>sc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume" },
      {
        "<leader>sk",
        "<cmd>Telescope keymaps show_plug=false<cr>",
        desc = "Key Maps",
      },

      {
        "<leader>/",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Search Word",
      },
      { "<leader>uC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme with preview" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>cd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definitions" },
      { "<leader>st", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definitions" },
      { "<leader>sR", "<cmd>Telescope lsp_references<cr>", desc = "Goto References" },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Goto Symbols" },
      { "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Goto Symbols (workspace)" },
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
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
            "--trim", "--fixed-strings"
          },
          mappings = {
            i = {
              ["<C-p>"] = action_layout.toggle_preview,
              ["<M-q>"] = open_selected,
              ["<C-Down>"] = require('telescope.actions').cycle_history_next,
              ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
            },
            n = {
              ["<C-p>"] = action_layout.toggle_preview,
              ["<M-q>"] = open_selected,
            }
          },
          history = {
            limit = 100,
            cycle_wrap = true,
          }
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
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    opts = {
      extensions = {
        fzf = {
          fuzzy = false,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case"
        }
      }
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("fzf")
    end
  },
  {
    "nvim-telescope/telescope-symbols.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>is", "<cmd>Telescope symbols<cr>", desc = "Insert Symbol" },
      {
        "<leader>ie",
        "<cmd>lua require'telescope.builtin'.symbols{sources={'emoji'}}<cr>",
        desc = "Insert Emoji",
      },
      {
        "<leader>ik",
        "<cmd>lua require'telescope.builtin'.symbols{sources={'kaomoji'}}<cr>",
        desc = "Insert Kaomoji",
      },
      {
        "<leader>ig",
        "<cmd>lua require'telescope.builtin'.symbols{sources={'gitmoji'}}<cr>",
        desc = "Insert Gitmoji",
      },
    },
  },
  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      opts = {
        extensions = {
          undo = {
            use_delta = false,
          }
        }
      },
    },
    keys = {
      { "<leader>su", "<cmd>Telescope undo<cr>", desc = "Undo" },
    },
    config = function()
      require("telescope").load_extension("undo")
    end
  },
  {
    "alan-w-255/telescope-mru.nvim",
    dependencies = {
      { "yegappan/mru", event = "VeryLazy" },
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>so", "<cmd>Telescope mru<cr>", desc = "MRU" },
    },
    config = function()
      require("telescope").load_extension("mru")
    end
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      opts = {
        extensions = {
          live_grep_args = {
            vimgrep_arguments = {
              "rg", "--color=never", "--no-heading", "--with-filename",
              "--line-number", "--column", "--hidden",
              "--trim"
            }
          }
        }
      },
    },
    keys = {
      { "<leader>sG", "<cmd>Telescope live_grep_args<cr>", desc = "Live Grep Args" },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  },
}

return {
  {
    "nvim-tree/nvim-tree.lua",
    -- event = "VeryLazy",
    event = function()
      local bufname = vim.api.nvim_buf_get_name(0)
      if vim.fn.isdirectory(bufname) == 1 then
        -- api.tree.open({ path = bufname })
        return {"BufEnter"}
      end
      -- return {"VeryLazy"}
    end,
    keys = {
      {
        '<leader>ee',
        '<cmd>NvimTreeFindFileToggle!<cr>',
        desc = 'Explorer'
      }
    },
    config = function ()
      local api = require('nvim-tree.api')

      local function on_attach(bufnr)
        local function opts(desc)
          return {
            desc = 'nvim-tree: ' .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
        end

        -- OR use all default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- remove a default
        -- vim.keymap.del('n', '<Tab>', { buffer = bufnr })

        -- override a default
        vim.keymap.set('n', '<C-P>', api.node.open.preview, opts('Open Preview'))
        vim.keymap.set('n', '<S-Tab>', api.node.open.preview, opts('Open Preview'))
      end

      require('nvim-tree').setup({
        on_attach = on_attach,
        hijack_cursor = true,
        sync_root_with_cwd = true,
        -- prefer_startup_root = true,
        -- reload_on_bufenter = true,
        respect_buf_cwd = true,
        view = {
          debounce_delay = 50,
          side = "right",
          signcolumn = "yes",
          width = 35,
        },
        renderer = {
          add_trailing = true,
          root_folder_label = function(path)
            return "../"..vim.fn.fnamemodify(path, ":t")
          end,
          indent_width = 2,
          symlink_destination = false,
          highlight_git = true,
          indent_markers = {
            enable = true,
            inline_arrows = false,
          },
          icons = {
            git_placement = "signcolumn",
            symlink_arrow = " > ",
            show = {
              file = false,
              folder = false,
              folder_arrow = false,
              bookmarks = false,
            },
            glyphs = {
              modified = "*",
              folder = {
                arrow_closed = "+",
                arrow_open = "-",
              },
              git = {
                unstaged = "M",
                staged = "A",
                unmerged = "C",
                renamed = "R",
                untracked = "U",
                deleted = "D",
                ignored = "I",
              },
            },
          }
        },
        update_focused_file = {
          enable = true,
          update_root = true
        },
        git = {
          enable = false,
          timeout = 1000,
        },
        diagnostics = {
          enable = false,
          debounce_delay = 1000,
          icons = {
            hint = "H",
            info = "I",
            warning = "W",
            error = "E"
          }
        },
        modified = { enable = true },
        live_filter = {
          always_show_folders = false,
        },
        filesystem_watchers = {
          debounce_delay = 100
        },
        actions = {
          file_popup = {
            open_win_config = {
              col = 1,
              row = 1,
              relative = "cursor",
              border = "single",
              style = "minimal",
            },
          },
          remove_file = {
            close_window = true
          }
        }
      })
      --
      -- local bufname = vim.api.nvim_buf_get_name(0)
      -- if vim.fn.isdirectory(bufname) == 1 then
      --   api.tree.open({ path = bufname })
      -- end
    end
  },
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
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
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
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require("telescope").load_extension("fzf")
      end
    },
  },
  {
    "nvim-telescope/telescope-symbols.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>ss", "<cmd>Telescope symbols<cr>", desc = "Symbols" },
      {
        "<leader>se",
        "<cmd>lua require'telescope.builtin'.symbols{sources={'emoji'}}<cr>",
        desc = "Emoji",
      },
      {
        "<leader>sk",
        "<cmd>lua require'telescope.builtin'.symbols{sources={'kaomoji'}}<cr>",
        desc = "Kaomoji",
      },
      {
        "<leader>sg",
        "<cmd>lua require'telescope.builtin'.symbols{sources={'gitmoji'}}<cr>",
        desc = "Gitmoji",
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
      { "<leader>eu", "<cmd>Telescope undo<cr>", desc = "Undo" },
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
      { "<leader>eo", "<cmd>Telescope mru<cr>", desc = "MRU" },
    },
    config = function()
      require("telescope").load_extension("mru")
    end
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>elG", "<cmd>Telescope live_grep_args<cr>", desc = "Live Grep Args" },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  },
  {
    "echasnovski/mini.jump2d",
    keys = {
      {
        "<cr>",
        "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
        mode = { "n", "x" },
        desc = "Start 2d jumping",
      }
    },
    opts = {
      mappings = { start_jumping = "" }
    },
  },
  {
    "echasnovski/mini.jump",
    keys = {
      { "f", mode = { "n", "x", "o" }, desc = 'Jump forward' },
      { "F", mode = { "n", "x", "o" }, desc = 'Jump backward' },
      { "t", mode = { "n", "x", "o" }, desc = 'Jump forward till' },
      { "T", mode = { "n", "x", "o" }, desc = 'Jump backward till' },
    },
    opts = { delay = { highlight = 0 } }
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      {
        "<leader>ed",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "Document Diagnostics"
      },
      {
        "<leader>eD",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Workspace Diagnostics"
      },
    },
    opts = {
      height = 15,
      icons = false,
      padding = false,
      fold_open = "-",
      fold_closed = "+",
      indent_lines = false,
      use_diagnostic_signs = true,
      auto_preview = false,
      auto_jump = {},
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '-' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      update_debounce = 1000,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 100,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      preview_config = { row = 1 }
    },
    keys = {
      {
        "<leader>ug",
        "<cmd>Gitsigns toggle_signs<cr>",
        desc = "Toggle Git Signs"
      },
      {
        "<leader>ub",
        "<cmd>Gitsigns toggle_current_line_blame<cr>",
        desc = "Toggle Git Line Blame"
      },
      {
        "ih",
        ":<C-U>Gitsigns select_hunk<CR>",
        mode = { "o", "x" },
        desc = "Select Hunk"
      },
      {
        "]h",
        "&diff ? ']h' : '<cmd>Gitsigns next_hunk<CR>'",
        desc = "Next Hunk",
        expr = true,
      },
      {
        "[h",
        "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
        desc = "Prev Hunk",
        expr = true,
      },
      {
        "<leader>hb",
        "<cmd>lua require('gitsigns').blame_line({full=true})<cr>",
        desc = "Blame Line"
      },
      {
        "<leader>hu",
        "<cmd>Gitsigns undo_stage_hunk<CR>",
        desc = "Undo Stage Hunk"
      },
      {
        "<leader>hp",
        "<cmd>Gitsigns preview_hunk<CR>",
        desc = "Preview Hunk"
      },
      {
        "<leader>hs",
        "<cmd>exe 'Gitsigns stage_hunk'|w<cr>",
        desc = "Stage Hunk"
      },
      {
        "<leader>hs",
        [[:<c-u>exe "'<,'>Gitsigns stage_hunk"|w<cr>]],
        mode = "x",
        desc = "Stage Hunk"
      },
      {
        "<leader>hr",
        ":Gitsigns reset_hunk<CR>",
        mode = { "n", "x" },
        desc = "Reset Hunk"
      },
      {
        "<leader>hS",
        "<cmd>exe 'Gitsigns stage_buffer'|w<cr>",
        desc = "Stage Buffer"
      },
      {
        "<leader>hR",
        "<cmd>exe 'Gitsigns reset_buffer'|Gitsigns refresh<cr>",
        desc = "Reset Buffer"
      }
    },
  },
  {
    "echasnovski/mini.files",
    keys = {
      {
        "<leader>E",
        "<cmd>lua MiniFiles.open(vim.fn.expand('%:p:h'))<CR>",
        desc = "Create files"
      }
    },
    config = function()
      local my_prefix = function(fs_entry)
        if fs_entry.fs_type == 'directory' then
          return '/', 'MiniFilesDirectory'
        end
        return
      end

      require('mini.files').setup({
        content = {
          prefix = my_prefix
        },
        options = {
          use_as_default_explorer = false,
        },
      })

      local open_split = function(direction)
        -- Make new window and set it as target
        local new_target_window
        vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
          vim.cmd(direction .. ' split')
          new_target_window = vim.api.nvim_get_current_win()
        end)

        MiniFiles.set_target_window(new_target_window)
      end

      local open_split_horizontal = function()
        open_split('belowright horizontal')
      end

      local open_split_vertical = function()
        open_split('belowright vertical')
      end

      local toggle_preview = function()
        local width_preview = vim.o.columns - 55
        local refresh_preview = function(value)
          MiniFiles.refresh({
            windows = { preview = value, width_preview = width_preview },
          })
          vim.b.mini_files_preview_opened = value
        end
        if vim.b.mini_files_preview_opened then
          refresh_preview(false)
          MiniFiles.trim_right()
        else
          refresh_preview(true)
        end
      end

      local custom_go_in_plus = function()
        for _ = 1, vim.v.count1 - 1 do
          MiniFiles.go_in()
        end
        local fs_entry = MiniFiles.get_fs_entry()
        local is_at_file = fs_entry ~= nil and fs_entry.fs_type == 'file'
        MiniFiles.go_in()
        if is_at_file then
          MiniFiles.close()
        else
          MiniFiles.trim_left()
        end
      end

      local custom_go_out_plus = function()
        for _ = 1, vim.v.count1 do
          MiniFiles.go_out()
        end
        MiniFiles.trim_right()
      end

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          local map = function(lhs, rhs, desc)
            local opts = { buffer = buf_id, desc = desc }
            vim.keymap.set('n', lhs, rhs, opts)
          end

          map('gs', open_split_horizontal, 'Open belowright horizontal')
          map('gv', open_split_vertical, 'Open belowright vertical')
          map('<c-p>', toggle_preview, 'Toggle preview')
          map('<tab>', toggle_preview, 'Toggle preview')
          map('<s-tab>', toggle_preview, 'Toggle preview')
          map('<cr>', custom_go_in_plus, 'Custom go in plus')
          map('-', custom_go_out_plus, 'Custom go out plus')
        end,
      })
    end
  }
}

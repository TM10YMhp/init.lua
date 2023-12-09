return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "ahmedkhalf/project.nvim",
      config = function ()
        require("project_nvim").setup({
          -- silent_chdir = false,
        })
        vim.cmd("ProjectRoot")
        require("tm10ymhp.utils").notify("project.nvim loaded")
      end
    },
    "debugloop/telescope-undo.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "yegappan/mru",
    "alan-w-255/telescope-mru.nvim",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  config = function ()
    local telescope = require("telescope")
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

    telescope.setup({
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
          modes = { "", "n", "v", "s", "x", "o", "!", "i", "l", "c", "t" }
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
        ["ui-select"] = {
          require("telescope.themes").get_ivy({
            -- even more opts
          })
        },
      }
    })

    -- Extensions
    telescope.load_extension("fzf")

    telescope.load_extension("projects")
    vim.keymap.set(
      'n',
      '<leader>ep',
      telescope.extensions.projects.projects,
      { desc = 'Projects' }
    )

    telescope.load_extension("undo")
    vim.keymap.set(
      'n',
      '<leader>eu',
      telescope.extensions.undo.undo,
      { desc = 'Undo' }
    )

    telescope.load_extension("live_grep_args")
    vim.keymap.set(
      'n',
      '<leader>elG',
      telescope.extensions.live_grep_args.live_grep_args,
      { desc = 'Live Grep Args' }
    )

    telescope.load_extension("ui-select")

    telescope.load_extension("mru")
    vim.keymap.set(
      'n',
      '<leader>eo',
      "<cmd>Telescope mru<cr>",
      { desc = 'MRU' }
    )
    --

    local builtin = require("telescope.builtin")

    local config_symbols = function (table)
      return function ()
        builtin.symbols({ sources = table })
      end
    end

    vim.keymap.set('n', '<leader>ss', builtin.symbols, {
      desc = 'Symbols'
    })
    vim.keymap.set('n', '<leader>se', config_symbols({"emoji"}), {
      desc = 'Symbols Emoji'
    })
    vim.keymap.set('n', '<leader>sk', config_symbols({"kaomoji"}), {
      desc = 'Symbols Kaomoji'
    })
    vim.keymap.set('n', '<leader>sg', config_symbols({"gitmoji"}), {
      desc = 'Symbols Gitmoji'
    })

    vim.keymap.set('n', '<leader>ek', function()
      builtin.keymaps({
        show_plug = false,
        layout_config = { width = 75 }
      })
    end, { desc = 'Key Maps' })

    vim.keymap.set('n', '<leader>ef', builtin.find_files, {
      desc = 'Find Files'
    })
    vim.keymap.set('n', '<leader>eF', '<cmd>Telescope find_files cwd=%:p:h<cr>', {
      desc = 'Find Files (cwd)'
    })
    vim.keymap.set('n', '<leader>eb', builtin.buffers, {
      desc = 'Buffers'
    })
    vim.keymap.set('n', '<leader>elg', builtin.live_grep, {
      desc = 'Live Grep'
    })
    vim.keymap.set('n', '<leader>ea', builtin.autocommands, {
      desc = 'Autocommands'
    })
    vim.keymap.set('n', '<leader>ec', builtin.commands, {
      desc = 'Commands'
    })
    vim.keymap.set('n', '<leader>eh', builtin.help_tags, {
      desc = 'Help Pages'
    })
    vim.keymap.set('n', '<leader>er', builtin.resume, {
      desc = 'Resume'
    })

    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {
      desc = 'Search Word'
    })
    vim.keymap.set('n', '<leader>uc', builtin.colorscheme, {
      desc = 'Colorscheme with preview'
    })
    vim.keymap.set('n', '<leader>uh', builtin.highlights, {
      desc = 'Highlight Groups'
    })

    vim.keymap.set('n', '<leader>cD', builtin.diagnostics, {
      desc = 'Workspace Diagnostics'
    })
    vim.keymap.set('n', '<leader>cd', '<cmd>Telescope diagnostics bufnr=0<cr>', {
      desc = 'Document Diagnostics'
    })

    vim.keymap.set('n', '<leader>cgd', builtin.lsp_definitions, {
      desc = 'Goto Definitions'
    })
    vim.keymap.set('n', '<leader>cgt', builtin.lsp_type_definitions, {
      desc = 'Goto Type Definitions'
    })
    vim.keymap.set('n', '<leader>cgr', builtin.lsp_references, {
      desc = 'Goto References'
    })
    vim.keymap.set('n', '<leader>cgs', builtin.lsp_document_symbols, {
      desc = 'Goto Symbols'
    })
    vim.keymap.set('n', '<leader>cgS', builtin.lsp_dynamic_workspace_symbols, {
      desc = 'Goto Symbols (workspace)'
    })
  end
}

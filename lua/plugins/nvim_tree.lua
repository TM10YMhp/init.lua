return {
  "nvim-tree/nvim-tree.lua",
  event = "VeryLazy",
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
      vim.keymap.del('n', '<Tab>', { buffer = bufnr })

      -- override a default
      vim.keymap.set('n', '<C-P>', api.node.open.preview, opts('Preview'))
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

    local bufname = vim.api.nvim_buf_get_name(0)
    if vim.fn.isdirectory(bufname) == 1 then
      api.tree.open({ path = bufname })
    end

    vim.keymap.set(
      'n',
      '<leader>ee',
      '<cmd>NvimTreeFindFileToggle!<cr>',
      { desc = 'Explorer' }
    )
  end
}

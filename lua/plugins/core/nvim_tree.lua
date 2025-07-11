return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "b0o/nvim-tree-preview.lua",
    opts = {
      border = "single",
      on_open = function(win)
        vim.api.nvim_win_set_option(win, "foldcolumn", "0")
      end,
    },
  },
  event = function()
    for _, value in ipairs(vim.fn.argv()) do
      if vim.fn.isdirectory(value) == 1 then return "BufEnter" end
    end

    return "CmdlineEnter :"
  end,
  keys = {
    {
      "<leader>ee",
      function()
        require("nvim-tree.api").tree.toggle({
          path = vim.fn.getcwd(),
        })
      end,
      desc = "Toggle nvim-tree",
    },
    {
      "<leader>eE",
      function()
        require("nvim-tree.api").tree.toggle({
          path = vim.fn.expand("%:p:h"),
        })
      end,
      desc = "Toggle nvim-tree to current directory",
    },
  },
  opts = {
    -- no modify this
    sync_root_with_cwd = true,
    update_focused_file = { enable = true },
    --
    sort = { sorter = "case_sensitive" },
    -- filters = {
    --   enable = false,
    --   git_ignored = false,
    -- },
    disable_netrw = true,
    view = {
      debounce_delay = 250,
      width = 33,
      side = "right",
      signcolumn = "no",
      preserve_window_proportions = true,
    },
    actions = {
      file_popup = {
        open_win_config = {
          border = "single",
        },
      },
      expand_all = {
        max_folder_discovery = 5,
      },
    },
    renderer = {
      -- full_name = true,
      add_trailing = true,
      root_folder_label = ":~:s?$?/?",
      highlight_git = true,
      indent_markers = { enable = true },
      hidden_display = "all",
      -- group_empty = true,
      icons = {
        git_placement = "right_align",
        diagnostics_placement = "right_align",
        bookmarks_placement = "after",
        show = {
          file = false,
          folder = false,
          folder_arrow = false,
          git = true,
          modified = true,
          hidden = false,
          diagnostics = true,
          bookmarks = true,
        },
        glyphs = {
          modified = "[+]",
          bookmark = "m",
          git = {
            unstaged = "M",
            staged = "A",
            unmerged = "C",
            renamed = "R",
            untracked = "?",
            deleted = "D",
            ignored = "!",
          },
        },
      },
    },
    git = {
      enable = false,
      show_on_open_dirs = false,
    },
    diagnostics = {
      enable = true,
      show_on_open_dirs = false,
      icons = {
        hint = "H",
        info = "I",
        warning = "W",
        error = "E",
      },
    },
    modified = {
      enable = true,
      show_on_open_dirs = false,
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      -- default mappings
      api.config.mappings.default_on_attach(bufnr)

      local function opts(desc)
        return {
          desc = "nvim-tree: " .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      -- nvim-tree-preview
      local preview = require("nvim-tree-preview")

      vim.keymap.set("n", "P", preview.watch, opts("Preview (Watch)"))
      vim.keymap.set(
        "n",
        "<Esc>",
        preview.unwatch,
        opts("Close Preview/Unwatch")
      )
      vim.keymap.set(
        "n",
        "<C-f>",
        function() return preview.scroll(4) end,
        opts("Scroll Down")
      )
      vim.keymap.set(
        "n",
        "<C-b>",
        function() return preview.scroll(-4) end,
        opts("Scroll Up")
      )

      -- Option A: Smart tab behavior: Only preview files, expand/collapse directories (recommended)
      vim.keymap.set("n", "<Tab>", function()
        local ok, node = pcall(api.tree.get_node_under_cursor)
        if ok and node then
          if node.type == "directory" then
            api.node.open.edit()
          else
            preview.node(node, { toggle_focus = true })
          end
        end
      end, opts("Preview"))

      -- Option B: Simple tab behavior: Always preview
      -- vim.keymap.set('n', '<Tab>', preview.node_under_cursor, opts 'Preview')
    end,
  },
}

return {
  "epwalsh/obsidian.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    require("obsidian").setup({
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/notes_md"
        }
      },
      notes_subdir = "Ideas",
      daily_notes = {
        folder = "journal",
        date_format = "%yw%W",
        template = "weekly_report_tmpl.md"
      },
      mappings = {},
      note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          suffix = tostring(os.time())
        end
        return suffix
      end,
      disable_frontmatter = true,
      templates = {
        subdir = "templates",
        substitutions = {
          ["date:YY\\wWW"] = function()
            return os.date("%yw%W", os.time())
          end,
          ["date:YY.MMDD"] = function()
            return os.date("%y.%m%d", os.time())
          end,
          ["time:HHmm|ss"] = function()
            return os.date("%H%M|%S", os.time())
          end,
        }
      },
      ui = {
        enable = false,
      },
      attachments = {
        img_folder = "files",
        img_text_func = function(client, path)
          local is_http = tostring(path):match("http.+")
          local link_path
          local vault_relative_path = client:vault_relative_path(path)
          if is_http == nil and vault_relative_path ~= nil then
            -- Use relative path if the image is saved in the vault dir.
            link_path = vault_relative_path
          elseif is_http ~= nil then
            link_path = tostring(is_http)
          else
            -- Otherwise use the absolute path.
            link_path = tostring(path)
          end
          local display_name = vim.fs.basename(link_path)
          return string.format("![%s](%s)", display_name, link_path)
        end,
      }
    })

    vim.keymap.set('n', '<leader>oo', '<cmd>ObsidianQuickSwitch<cr>', {
      desc = "Obsidian Quick Switch"
    })
    vim.keymap.set('n', '<leader>on', '<cmd>ObsidianNew<cr>', {
      desc = "Obsidian New"
    })
    vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianTemplate<cr>', {
      desc = "Obsidian Template"
    })
    vim.keymap.set('n', '<leader>of', '<cmd>ObsidianFollowLink<cr>', {
      desc = "Obsidian Follow Link"
    })
    vim.keymap.set('n', '<leader>od', '<cmd>ObsidianToday<cr>', {
      desc = "Obsidian Today"
    })
    vim.keymap.set('n', '<leader>oy', '<cmd>ObsidianPasteImg<cr>', {
      desc = "Obsidian Paste Img"
    })
    vim.keymap.set('n', '<leader>ob', '<cmd>ObsidianBacklinks<cr>', {
      desc = "Obsidian Backlinks"
    })
    vim.keymap.set('n', '<leader>os', '<cmd>ObsidianSearch<cr>', {
      desc = "Obsidian Search"
    })
  end
}

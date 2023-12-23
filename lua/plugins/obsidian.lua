local obsidian_dir = "~/vaults/notes_md"

return {
  "epwalsh/obsidian.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>oo", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Quick Switch" },
    { "<leader>on", "<cmd>e "..obsidian_dir.."<cr>", desc = "Obsidian Directory" },
    { "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Obsidian Template" },
    { "<leader>of", "<cmd>ObsidianFollowLink<cr>", desc = "Obsidian Follow Link" },
    { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Obsidian Today" },
    { "<leader>oy", "<cmd>ObsidianPasteImg<cr>", desc = "Obsidian Paste Img" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Obsidian Backlinks" },
    { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = obsidian_dir,
      }
    },
    notes_subdir = "inbox",
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
  },
}

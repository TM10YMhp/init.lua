local is_http = function()
  if vim.bo.filetype ~= 'http' then
    require("tm10ymhp.utils").notify(
      'RestNvim is only supported for HTTP requests',
      vim.log.levels.ERROR
    )

    return false
  end

  return true
end

local obsidian_dir = "~/vaults/notes_md"

return {
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      result_split_horizontal = true,
      result = {
        show_curl_command = true,
      }
    },
    keys = {
      {
        '<leader>rr',
        function()
          if is_http() then require("rest-nvim").run() end
        end,
        desc = "RestNvim Run"
      },
      {
        '<leader>rl',
        function()
          if is_http() then require("rest-nvim").last() end
        end,
        desc = "RestNvim Last"
      },
      {
        '<leader>rp',
        function()
          if is_http() then require("rest-nvim").run(true) end
        end,
        desc = "RestNvim Preview"
      },
    },
    config = function(_, opts)
      require("rest-nvim").setup(opts)
    end
  },
  {
    "laytan/cloak.nvim",
    ft = "dotenv",
    keys = {
      { '<leader>uC', '<cmd>CloakToggle<cr>', desc = "Toggle Cloak" }
    },
    opts = {
      enabled = true,
      cloak_character = '*',
      highlight_group = 'Comment',
      patterns = {
        {
          file_pattern = ".env*",
          cloak_pattern = "=.+",
        }
      }
    },
  },
  {
    "ThePrimeagen/harpoon",
    keys = {
      {
        "<leader>ma",
        function() require('harpoon.mark').add_file() end,
        desc = "Harpoon: Add File"
      },
      {
        "<leader>mm",
        function() require("harpoon.ui").toggle_quick_menu() end,
        desc = "Harpoon: Menu"
      },
      {
        "<leader>1",
        function() require("harpoon.ui").nav_file(1) end,
        desc = "Harpoon: Nav File 1"
      },
      {
        "<leader>2",
        function() require("harpoon.ui").nav_file(2) end,
        desc = "Harpoon: Nav File 2"
      },
      {
        "<leader>3",
        function() require("harpoon.ui").nav_file(3) end,
        desc = "Harpoon: Nav File 3"
      },
      {
        "<leader>4",
        function() require("harpoon.ui").nav_file(4) end,
        desc = "Harpoon: Nav File 4"
      }
    },
    config = true
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install && git restore .",
    ft = "markdown",
    keys = {
      { "<leader>up", "<cmd>MarkdownPreviewToggle<CR>", desc = "Toggle Markdown Preview" },
    },
  },
  {
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
  },
  {
    "voldikss/vim-floaterm",
    keys = {
      {
        '<leader>ts',
        ':FloatermSend<cr>',
        mode = 'x',
        desc = "Send command to a job in floaterm"
      },
      {
        '<leader>t"',
        "<cmd>FloatermNew --wintype=split --height=0.35<cr>",
        desc = "Open a split floaterm window"
      },
      {
        '<leader>tC',
        "<cmd>FloatermNew --cwd=<buffer><cr>",
        desc = "Open a floaterm window (cwd)"
      },
      {
        '<leader>t&',
        [[<c-\><c-n><cmd>exe 'FloatermKill'|FloatermNext<cr>]],
        mode = 't',
        desc = "Kill the current floaterm instance"
      },
      {
        '<leader>tc',
        '<cmd>FloatermNew<cr>',
        desc = "Open a floaterm window"
      },
      {
        '<leader>tp',
        '<cmd>FloatermPrev<cr>',
        desc = "Switch to the previous floaterm instance"
      },
      {
        '<leader>tn',
        '<cmd>FloatermNext<cr>',
        desc = "Switch to the next floaterm instance"
      },
      {
        '<leader>th',
        '<cmd>FloatermToggle<cr>',
        desc = "Open or hide the floaterm window"
      },

      {
        '<leader>tc',
        [[<c-\><c-n><cmd>FloatermNew<cr>]],
        mode = 't',
        desc = "Open a floaterm window"
      },
      {
        '<leader>tp',
        [[<c-\><c-n><cmd>FloatermPrev<cr>]],
        mode = 't',
        desc = "Switch to the previous floaterm instance"
      },
      {
        '<leader>tn',
        [[<c-\><c-n><cmd>FloatermNext<cr>]],
        mode = 't',
        desc = "Switch to the next floaterm instance"
      },
      {
        '<leader>th',
        [[<c-\><c-n><cmd>FloatermToggle<cr>]],
        mode = 't',
        desc = "Open or hide the floaterm window"
      },
    },
  }
}

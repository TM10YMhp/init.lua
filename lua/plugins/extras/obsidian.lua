return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "epwalsh/obsidian.nvim",
    keys = {
      {
        "<leader>oe",
        "<cmd>Neotree dir=" .. SereneNvim.config.extras.obsidian_dir .. "<cr>",
        desc = "Obsidian Explorer",
      },
      { "<leader>oT", "<cmd>ObsidianTemplate<cr>", desc = "Obsidian Template" },
      --
      { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Obsidian Today" },
      {
        "<leader>oy",
        "<cmd>ObsidianPasteImg<cr>",
        desc = "Obsidian Paste Img",
      },
      --
      {
        "<leader>oo",
        "<cmd>ObsidianQuickSwitch<cr>",
        desc = "Obsidian Quick Switch",
      },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },
      { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Obsidian Links" },
      { "<leader>ot", "<cmd>ObsidianTags<cr>", desc = "Obsidian Backlinks" },
      {
        "<leader>ob",
        "<cmd>ObsidianBacklinks<cr>",
        desc = "Obsidian Backlinks",
      },
      {
        "<leader>of",
        "<cmd>ObsidianFollowLink<cr>",
        desc = "Obsidian Follow Link",
      },
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = SereneNvim.config.extras.obsidian_dir,
        },
      },
      notes_subdir = "inbox",
      daily_notes = {
        folder = "journal",
        date_format = "%yw%W",
        template = "weekly_report_tmpl.md",
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
      preferred_link_style = "markdown",
      disable_frontmatter = true,
      templates = {
        folder = "templates",
        substitutions = {
          ["date:YY\\wWW"] = function()
            return os.date("%yw%W")
          end,
          ["date:YY.MMDD"] = function()
            return os.date("%y.%m%d")
          end,
          ["time:HHmm|ss"] = function()
            return os.date("%H%M|%S")
          end,
        },
      },
      ui = { enable = false },
      attachments = { img_folder = "files" },
    },
  },
}

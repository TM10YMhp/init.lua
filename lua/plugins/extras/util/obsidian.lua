return {
  {
    "obsidian-nvim/obsidian.nvim",
    cmd = "Obsidian",
    keys = {
      { "<leader>n", "", desc = "+notes" },
      {
        "<leader>ne",
        function()
          require("nvim-tree.api").tree.toggle({
            path = vim.fn.expand(SereneNvim.config.extras.obsidian_dir),
          })
        end,
        desc = "Obsidian Explorer",
      },
      { "<leader>nT", "<cmd>ObsidianTemplate<cr>", desc = "Obsidian Template" },
      --
      { "<leader>nd", "<cmd>ObsidianToday<cr>", desc = "Obsidian Today" },
      {
        "<leader>np",
        "<cmd>Obsidian paste_img<cr>",
        desc = "Obsidian Paste Img",
      },
      --
      {
        "<leader>ns",
        "<cmd>Obsidian quick_switch<cr>",
        desc = "Obsidian Quick Switch",
      },
      { "<leader>ng", "<cmd>Obsidian search<cr>", desc = "Obsidian Search" },
      { "<leader>nl", "<cmd>Obsidian links<cr>", desc = "Obsidian Links" },
      { "<leader>nt", "<cmd>Obsidian tags<cr>", desc = "Obsidian Backlinks" },
      {
        "<leader>nb",
        "<cmd>Obsidian backlinks<cr>",
        desc = "Obsidian Backlinks",
      },
      {
        "<leader>nf",
        "<cmd>Obsidian follow_link<cr>",
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
      completion = { nvim_cmp = false },
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
          ["date:YY\\wWW"] = function() return os.date("%yw%W") end,
          ["date:YY.MMDD"] = function() return os.date("%y.%m%d") end,
          ["time:HHmm|ss"] = function() return os.date("%H%M|%S") end,
        },
      },
      ui = { enable = false },
      attachments = { img_folder = "files" },
    },
  },
}

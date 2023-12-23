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
      { '<leader>uc', '<cmd>CloakToggle<cr>', desc = "Toggle Cloak" }
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
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
    keys = {
      {
        "<leader>gb",
        ":G blame<cr>",
        mode = { "n", "x" },
        desc = "Git Blame"
      },
    },
  },
}

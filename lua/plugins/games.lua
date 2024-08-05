return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>v", group = "games" },
      },
    },
  },
  {
    "Eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      {
        "<leader>vr",
        "<cmd>CellularAutomaton make_it_rain<CR>",
        desc = "Rain",
      },
      {
        "<leader>vx",
        "<cmd>CellularAutomaton scramble<CR>",
        desc = "Scramble",
      },
      {
        "<leader>vl",
        "<cmd>CellularAutomaton game_of_life<CR>",
        desc = "Game Of Life",
      },
    },
  },
  {
    "seandewar/killersheep.nvim",
    cmd = "KillKillKill",
    keys = {
      {
        "<leader>vk",
        "<cmd>KillKillKill<CR>",
        desc = "Play Killer Sheep",
      },
    },
    opts = {
      keymaps = {
        move_left = "<Left>",
        move_right = "<Right>",
        shoot = "s",
      },
    },
  },
  {
    "seandewar/nvimesweeper",
    cmd = "Nvimesweeper",
    keys = {
      {
        "<leader>vw",
        "<cmd>Nvimesweeper<CR>",
        desc = "Play MineSweeper",
      },
    },
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
    keys = {
      {
        "<leader>vg",
        "<cmd>VimBeGood<CR>",
        desc = "Play VimBeGood",
      },
    },
    config = function()
      local mod = require("vim-be-good")

      local menu = mod.menu
      mod.menu = function()
        menu()

        local win = vim.api.nvim_get_current_win()
        local config = vim.api.nvim_win_get_config(win)
        vim.api.nvim_win_set_config(win, {
          border = "single",
          height = config.height - 2,
        })
        vim.wo[win].wrap = true

        local buf = vim.api.nvim_get_current_buf()
        vim.bo[buf].filetype = "vim-be-good"
        vim.bo[buf].buflisted = false
        vim.keymap.set(
          "n",
          "q",
          "<cmd>close<cr>",
          { buffer = buf, silent = true }
        )
      end

      local onVimResize = mod.onVimResize
      mod.onVimResize = function()
        onVimResize()

        local win = vim.api.nvim_get_current_win()
        local config = vim.api.nvim_win_get_config(win)
        vim.api.nvim_win_set_config(win, {
          height = config.height - 2,
        })
      end

      vim.api.nvim_create_user_command("VimBeGood", function()
        require("vim-be-good").menu()
      end, {})
    end,
  },
  {
    "alec-gibson/nvim-tetris",
    cmd = "Tetris",
    keys = {
      {
        "<leader>vt",
        "<cmd>Tetris<CR>",
        desc = "Play Tetris",
      },
    },
    config = function()
      local mod = require("nvim-tetris.main")

      local init = mod.init
      mod.init = function()
        init()

        local win = vim.api.nvim_get_current_win()
        local config = vim.api.nvim_win_get_config(win)
        vim.api.nvim_win_set_config(win, { border = "single" })
        vim.wo[win].wrap = true

        local buf = vim.api.nvim_get_current_buf()
        vim.bo[buf].buflisted = false
        vim.keymap.set(
          "n",
          "q",
          "<cmd>close<cr>",
          { buffer = buf, silent = true }
        )
      end
    end,
  },
  -- TODO: fix cursor move in rain
  {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    keys = {
      {
        "<leader>vf",
        "<cmd>Speedtyper<CR>",
        desc = "Type Speed Game",
      },
    },
    opts = {
      window = {
        border = "single",
        close_with = "q",
      },
      highlights = {
        falling_word_typed = "DiffAdd",
      },
    },
    config = function(_, opts)
      local mod = require("speedtyper.window")
      local open_float = mod.open_float
      mod.open_float = function(_opts)
        open_float(_opts)

        vim.api.nvim_set_option_value("stc", "", { scope = "local" })
        vim.opt_local.scrolloff = 0
      end

      require("speedtyper").setup(opts)
    end,
  },
}

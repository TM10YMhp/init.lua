return {
  "folke/flash.nvim",
  keys = {
    -- "/",
    -- "?",
    "f",
    "F",
    "t",
    "T",
    -- ";",
    -- ",",
    {
      "<leader>fs",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "<leader>fS",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
    {
      "<leader>fr",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "<leader>fR",
      mode = { "o", "x" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
    {
      "<leader>/",
      [[/<cmd>lua require("flash").toggle()<cr>]],
      desc = "Flash Search Forward",
    },
    {
      "<leader>?",
      [[?<cmd>lua require("flash").toggle()<cr>]],
      desc = "Flash Search Backward",
    },
    {
      "<leader>/",
      mode = "x",
      [[<esc>/\%V<cmd>lua require("flash").toggle()<cr>]],
      desc = "Flash Search Forward within range",
    },
    {
      "<leader>?",
      mode = "x",
      [[<esc>?\%V<cmd>lua require("flash").toggle()<cr>]],
      desc = "Flash Search Backward within range",
    },
  },
  opts = {
    highlight = {
      backdrop = false,
    },
    modes = {
      search = {
        enabled = false,
      },
      char = {
        jump_labels = true,
        highlight = {
          backdrop = false,
        },
      },
    },
  },
  config = function(_, opts)
    require("flash").setup(opts)

    local augroup =
      vim.api.nvim_create_augroup("plugins.flash", { clear = true })
    vim.api.nvim_create_autocmd("CmdlineLeave", {
      group = augroup,
      pattern = { "/", "?" },
      callback = function()
        require("flash").toggle(false)
      end,
    })
  end,
}

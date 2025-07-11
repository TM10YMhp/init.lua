local lazygit = function(cmd)
  return require("toggleterm.terminal").Terminal:new({
    cmd = "lazygit " .. (cmd or ""),
    direction = "tab",
    on_create = function(t)
      vim.keymap.set("t", "<esc>", "<nop>", { buffer = t.bufnr })
    end,
    close_on_exit = true,
  })
end

return {
  "akinsho/toggleterm.nvim",
  cmd = "ToggleTerm",
  keys = {
    {
      "<leader>gg",
      function() lazygit():toggle() end,
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      function() lazygit("log"):toggle() end,
      desc = "Lazygit log",
    },
    {
      "<leader>gf",
      function() lazygit("-f " .. vim.fn.expand("%")):toggle() end,
      desc = "Lazygit log file",
    },

    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>" },
    { "<C-\\>", '<cmd>exe v:count . "ToggleTerm"<cr>' },
    { "<C-\\>", "<cmd>ToggleTerm<cr>", mode = "t" },
    { "<C-\\>", "<esc><cmd>ToggleTerm<cr>", mode = "i" },
    { "<M-t>q", [[<c-\><c-n><cmd>wincmd p<cr>]], mode = "t" },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return vim.o.lines * 0.35
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    float_opts = {
      border = "single",
      width = function() return math.floor(vim.o.columns * 0.9) end,
      height = function() return math.floor(vim.o.lines * 0.9) end,
    },
    close_on_exit = false,
    shade_terminals = false,
  },
}

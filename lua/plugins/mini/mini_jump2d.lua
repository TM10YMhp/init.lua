return {
  ---@module "mini.jump2d"
  "echasnovski/mini.jump2d",
  keys = {
    {
      "<M-f>",
      "<cmd>lua MiniJump2d.start(MiniJump2d.builtin_opts.single_character)<CR>",
      mode = { "n", "o", "x" },
      desc = "Start 2d jumping",
    },
    {
      "<M-f>",
      function()
        vim.api.nvim_input("<cr>")

        vim.schedule(function()
          local pattern = vim.fn.getreg("/"):gsub([[\\]], [[\]])

          if pattern:sub(1, 2) == [[\<]] and pattern:sub(-2) == [[\>]] then
            pattern = "%f[A-Za-z]" .. pattern:sub(3, -3) .. "%f[^A-Za-z]"
          end

          if pattern:sub(1, 2) == [[\V]] then
            pattern = pattern:sub(3)
          end

          if pattern:sub(1, 3) == [[\%V]] then
            pattern = pattern:sub(4)
          end

          if pattern == "" then
            SereneNvim.warn("No spots to show.", { title = "mini.jump2d" })
            return
          end

          local x = vim.fn.matchlist(pattern, [[\v\((.+)\|(.+)\|(.+)\)]])
          if #x ~= 0 then
            local spotters = {
              MiniJump2d.gen_pattern_spotter(x[2]),
              MiniJump2d.gen_pattern_spotter(x[3]),
              MiniJump2d.gen_pattern_spotter(x[4]),
            }
            MiniJump2d.start({
              allowed_lines = { blank = false, fold = false },
              spotter = MiniJump2d.gen_union_spotter(unpack(spotters)),
            })
          else
            MiniJump2d.start({
              allowed_lines = { blank = false, fold = false },
              spotter = MiniJump2d.gen_pattern_spotter(pattern),
            })
          end
        end)
      end,
      mode = { "c" },
      desc = "Start 2d jumping",
    },
  },
  opts = {
    mappings = { start_jumping = "" },
    labels = "asdfghjklqwertyuiopzxcvbnm",
  },
}

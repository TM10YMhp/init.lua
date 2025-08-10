return {
  setup = function()
    -- vim.keymap.set("n", "<Plug>(SayHello)", function()
    --   local t = require("injections.template")
    --   t.run()
    -- end, { noremap = true })

    vim.api.nvim_create_user_command("RunInjections", function()
      local t = require("injections.template")
      t.run()
    end, {})
  end,
}

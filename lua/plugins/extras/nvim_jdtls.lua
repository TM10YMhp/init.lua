vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  callback = function()
    vim.defer_fn(function()
      -- TODO: move to utils
      local get_java_bufnrs = function()
        local res = {}
        for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
          if not vim.api.nvim_buf_is_loaded(bufnr) then
            goto continue
          end

          if
            vim.api.nvim_get_option_value("filetype", { buf = bufnr }) == "java"
          then
            table.insert(res, bufnr)
          end

          ::continue::
        end

        return res
      end

      local jdtls = require("jdtls")
      local config = require("servers.jdtls")

      if vim.g.my_jdtls_autostart then
        jdtls.start_or_attach(config)
      end

      vim.api.nvim_buf_create_user_command(0, "LspStart", function()
        if vim.api.nvim_get_option_value("modified", {}) then
          SereneNvim.warn("JDTLS: Can't start on modified buffer")
          return
        end

        vim.g.my_jdtls_autostart = true

        local bufnrs = get_java_bufnrs()
        if #bufnrs == 0 then
          SereneNvim.info("JDTLS: No java files found")
          return
        end

        for _, bufnr in ipairs(bufnrs) do
          jdtls.start_or_attach(config, {}, {
            bufnr = bufnr,
          })
        end
        SereneNvim.info("JDTLS: started for " .. #bufnrs .. " java files")
      end, {})

      vim.api.nvim_buf_create_user_command(0, "LspStop", function()
        vim.g.my_jdtls_autostart = false
        vim.lsp.stop_client(vim.lsp.get_clients())
      end, {})

      vim.api.nvim_buf_create_user_command(0, "LspRestart", function()
        vim.cmd("JdtRestart")
      end, {})
    end, 10)
  end,
})

return {
  "mfussenegger/nvim-jdtls",
  config = function()
    local jdtls = require("jdtls")

    -- DAP config
    local dap = require("dap")
    dap.configurations.java = {
      {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
      },
    }

    jdtls.setup_dap({ hotcodereplace = "auto" })

    vim.keymap.set(
      "n",
      "<leader>da",
      "<cmd>lua require'dap'.continue()<CR>",
      { desc = "Debug: Start" }
    )
  end,
}

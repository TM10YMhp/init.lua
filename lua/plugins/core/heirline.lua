local git_branch = {
  provider = function()
    if vim.b.gitsigns_head then
      return " " .. vim.b.gitsigns_head .. " "
    end
  end,
  update = {
    "User",
    pattern = { "GitSignsUpdate", "GitSignsChanged" },
    callback = function()
      vim.schedule(vim.cmd.redrawstatus)
    end,
  },
}

local git_diff = {
  provider = function()
    return "%{get(b:,'gitsigns_status','')}"
  end,
  update = {
    "User",
    pattern = { "GitSignsUpdate", "GitSignsChanged" },
    callback = function()
      vim.schedule(vim.cmd.redrawstatus)
    end,
  },
}

local filesize = {
  provider = function()
    -- stackoverflow, compute human readable file size
    local suffix = { "b", "k", "M", "G", "T", "P", "E" }
    local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
    fsize = (fsize < 0 and 0) or fsize
    if fsize < 1024 then
      return fsize .. suffix[1]
    end
    local i = math.floor((math.log(fsize) / math.log(1024)))
    return string.format("%.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
  end,
}

local workspace_diagnostic = {
  provider = function()
    local res = {
      [vim.diagnostic.severity.ERROR] = 0,
      [vim.diagnostic.severity.WARN] = 0,
      [vim.diagnostic.severity.INFO] = 0,
      [vim.diagnostic.severity.HINT] = 0,
    }
    for _, v in ipairs(vim.diagnostic.get()) do
      res[v.severity] = res[v.severity] + 1
    end

    local errors = res[1]
    local warnings = res[2]
    local infos = res[3]
    local hints = res[4]

    return " "
      .. vim.trim(
        (errors > 0 and "E" .. errors .. " " or "")
          .. (warnings > 0 and "W" .. warnings .. " " or "")
          .. (infos > 0 and "I" .. infos .. " " or "")
          .. (hints > 0 and "H" .. hints .. " " or "")
      )
      .. " "
  end,
  update = { "DiagnosticChanged" },
}

local lsp_active = {
  provider = function()
    local clients = #vim.lsp.get_clients()

    if clients > 0 then
      return "[" .. clients .. "]" .. " "
    end
    return " "
  end,
  update = { "LspAttach", "LspDetach" },
}

return {
  "rebelot/heirline.nvim",
  event = "VeryLazy",
  opts = {
    opts = {
      disable_winbar_cb = function()
        if vim.list_contains({ "fugitiveblame" }, vim.o.filetype) then
          return false
        end

        return vim.fn.win_gettype() == "popup"
          or not vim.list_contains({ "", "help" }, vim.o.buftype)
          or vim.list_contains({ "dashboard" }, vim.o.filetype)
      end,
    },
    statusline = {
      git_branch,
      {
        provider = table.concat({
          " ",
          '%l:%{charcol(".")}|%{charcol("$")-1}',
          "%=", -- End left alignment
        }, ""),
      },
      git_diff,
      workspace_diagnostic,
      {
        provider = function()
          return table.concat({
            "",
            vim.o.encoding,
            vim.o.fileformat,
            vim.o.filetype,
          }, " ")
        end,
      },
      lsp_active,
      filesize,
      { provider = " %L " },
    },
    winbar = {
      SereneNvim.heirline.absolute_path,
    },
  },
  config = function(_, opts)
    require("heirline").setup(opts)

    if not opts.opts.disable_winbar_cb() then
      vim.opt_local.winbar = "%{%v:lua.require'heirline'.eval_winbar()%}"
    end
  end,
}

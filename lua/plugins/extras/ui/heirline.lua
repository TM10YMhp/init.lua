-- TODO: strings not respect update
local git_branch = {
  provider = function()
    return vim.g.gitsigns_head or ""
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
  provider = function(self)
    local status = (vim.b[self and self.bufnr or 0].gitsigns_status or ""):gsub(
      "%s+",
      ""
    )
    return status ~= "" and "[" .. status .. "]" or ""
  end,
  update = {
    "User",
    pattern = { "GitSignsUpdate", "GitSignsChanged" },
    callback = function()
      vim.schedule(vim.cmd.redrawstatus)
    end,
  },
  -- https://github.com/rebelot/heirline.nvim/issues/71#issuecomment-1272940354
  init = function(self)
    if not rawget(self, "once") then
      local clear_cache = function()
        self._win_cache = nil
      end
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = clear_cache,
      })
      self.once = true
    end
  end,
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
  update = { "BufWritePost" },
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

    return vim.trim(
      (errors > 0 and "E" .. errors or "")
        .. (warnings > 0 and "W" .. warnings or "")
        .. (infos > 0 and "I" .. infos or "")
        .. (hints > 0 and "H" .. hints or "")
    )
  end,
  update = { "DiagnosticChanged" },
}

local lsp_active = {
  provider = function()
    local clients = #vim.lsp.get_clients()

    if clients > 0 then
      return "[" .. clients .. "]"
    end
  end,
  update = { "LspAttach", "LspDetach" },
}

local file_encoding = {
  provider = function()
    return (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
  end,
}

local file_format = {
  provider = function()
    return vim.bo.fileformat
  end,
}

local file_type = {
  provider = function()
    return vim.bo.filetype
  end,
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
      git_diff,
      { provider = " " },
      { provider = '%l:%{charcol(".")}|%{charcol("$")-1}' },
      { provider = "%=" },
      file_encoding,
      { provider = " " },
      file_format,
      { provider = " " },
      file_type,
      lsp_active,
      workspace_diagnostic,
      { provider = " " },
      filesize,
      { provider = " " },
      { provider = "%L" },
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

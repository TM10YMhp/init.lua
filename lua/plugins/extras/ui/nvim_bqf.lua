return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      preview = {
        auto_preview = false,
        border = "single",
        delay_syntax = 100,
        win_height = 20,
        winblend = 0,
        -- show_title = false,
      },
      func_map = {
        open = "",
        openc = "",
        drop = "",
        split = "",
        vsplit = "",
        tab = "",
        tabb = "",
        tabc = "",
        tabdrop = "",
        ptogglemode = "zp",
        ptoggleitem = "p",
        ptoggleauto = "P",
        pscrollup = "<C-b>",
        pscrolldown = "<C-f>",
        pscrollorig = "zo",
        prevfile = "<S-Tab>",
        nextfile = "<Tab>",
        prevhist = "",
        nexthist = "",
        lastleave = "",
        stoggleup = "",
        stoggledown = "",
        stogglevm = "",
        stogglebuf = "",
        sclear = "",
        filter = "",
        filterr = "",
        fzffilter = "",
      },
    },
  },
  {
    "stevearc/quicker.nvim",
    ft = "qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      opts = {
        number = true,
      },
      type_icons = {
        E = "E ",
        W = "W ",
        I = "I ",
        N = "N ",
        H = "H ",
      },
      max_filename_width = function()
        if
          vim.w.qf_toc
          or (vim.w.quickfix_title and vim.w.quickfix_title:find("TOC"))
        then
          return 0
        end
        return math.floor(math.min(95, vim.o.columns / 2))
      end,
    },
  },
}

return {
  "voldikss/vim-floaterm",
  cmd = { "FloatermNew", "F" },
  keys = {
    {
      "<M-t>a",
      "<cmd>F tgpt -i<cr>",
      desc = "TGPT",
    },

    {
      "<leader>gG",
      "<cmd>FloatermNew --title=─ lazygit<cr>",
      desc = "Lazygit",
    },
    {
      "<leader>gl",
      "<cmd>FloatermNew --title=─ lazygit log<cr>",
      desc = "Lazygit log",
    },
    {
      "<leader>gf",
      "<cmd>FloatermNew --title=─ lazygit -f %<cr>",
      desc = "Lazygit log file",
    },

    {
      "<M-t>s",
      ":FloatermSend<cr>",
      mode = "x",
      desc = "Send command to a job in floaterm",
    },
    {
      '<M-t>"',
      "<cmd>FloatermNew --wintype=split --height=0.35<cr>",
      desc = "Open a split floaterm window",
    },
    {
      "<M-t>%",
      "<cmd>FloatermNew --wintype=vsplit --width=0.40<cr>",
      desc = "Open a vsplit floaterm window",
    },
    {
      "<M-t>C",
      "<cmd>FloatermNew --cwd=<buffer><cr>",
      desc = "Open a floaterm window (cwd)",
    },
    {
      "<M-t>c",
      "<cmd>FloatermNew<cr>",
      desc = "Open a floaterm window",
    },
    {
      "<M-t>p",
      "<cmd>FloatermPrev<cr>",
      desc = "Switch to the previous floaterm instance",
    },
    {
      "<M-t>n",
      "<cmd>FloatermNext<cr>",
      desc = "Switch to the next floaterm instance",
    },
    {
      "<M-t>t",
      "<cmd>FloatermToggle<cr>",
      desc = "Open or hide the floaterm window",
    },
    {
      "<M-t>t",
      [[<c-\><c-n><cmd>FloatermToggle<cr>]],
      mode = "t",
      desc = "Open or hide the floaterm window",
    },
    {
      "<M-t>j",
      [[<c-\><c-n><cmd>FloatermUpdate --wintype=split --height=0.35<cr>]],
      mode = "t",
      desc = "Update a split floaterm window",
    },
    {
      "<M-t>h",
      [[<c-\><c-n><cmd>FloatermUpdate --wintype=vsplit --width=0.40<cr>]],
      mode = "t",
      desc = "Update a vsplit floaterm window",
    },
    {
      "<M-t>&",
      [[<c-\><c-n><cmd>exe 'FloatermKill'|FloatermNext<cr>]],
      mode = "t",
      desc = "Kill the current floaterm instance",
    },
    {
      "<M-t>c",
      [[<c-\><c-n><cmd>FloatermNew<cr>]],
      mode = "t",
      desc = "Open a floaterm window",
    },
    {
      "<M-t>p",
      [[<c-\><c-n><cmd>FloatermPrev<cr>]],
      mode = "t",
      desc = "Switch to the previous floaterm instance",
    },
    {
      "<M-t>n",
      [[<c-\><c-n><cmd>FloatermNext<cr>]],
      mode = "t",
      desc = "Switch to the next floaterm instance",
    },
    {
      "<M-t>q",
      [[<c-\><c-n><cmd>wincmd p<cr>]],
      mode = "t",
      desc = "Switch back to the previous window",
    },
  },
  config = function()
    vim.api.nvim_create_user_command("F", function(info)
      local args = info.args
      vim.cmd(
        "FloatermNew --wintype=split --height=0.35 --autoclose=0" .. " " .. args
      )
    end, { bang = true, nargs = "*" })

    vim.g.floaterm_width = 0.9
    vim.g.floaterm_height = 0.9
    vim.g.floaterm_autohide = 2

    vim.api.nvim_create_autocmd("BufLeave", {
      group = vim.api.nvim_create_augroup(
        "tm10ymhp_hide_floaterm",
        { clear = true }
      ),
      desc = "Hide floaterm when leaving buffer",
      callback = function(event)
        if
          vim.bo[event.buf].filetype == "floaterm"
          and vim.fn.win_gettype() == "popup"
        then
          vim.schedule(function()
            local found_winnr = vim.fn["floaterm#window#find"]()
            if found_winnr > 0 then
              vim.fn["floaterm#window#hide"](event.buf)
            end
          end)
        end
      end,
    })
  end,
}

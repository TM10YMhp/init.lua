return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          on_new_config = function(new_config)
            new_config.settings.texlab.build.args = new_config.settings.texlab.build.args
              or {}
            vim.list_extend(new_config.settings.texlab.build.args, {
              "-outdir=build",
              "-pdflatex=xelatex",
            })
          end,
          settings = {
            texlab = {
              build = {
                onSave = true,
              },
            },
          },
        },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "latexindent" } },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        tex = { "latexindent" },
      },
      formatters = {
        latexindent = {
          append_args = { "-m", "-l" },
        },
      },
    },
  },
}

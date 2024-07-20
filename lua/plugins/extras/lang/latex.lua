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
}

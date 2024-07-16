return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              build = {
                args = vim.list_extend(
                  require("lspconfig.server_configurations.texlab").default_config.settings.texlab.build.args,
                  {
                    "-outdir=build",
                    "-pdflatex=xelatex",
                  }
                ),
                onSave = true,
              },
            },
          },
        },
      },
    },
  },
}

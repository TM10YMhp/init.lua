local default_args =
  require("lspconfig.server_configurations.texlab").default_config.settings.texlab.build.args

return {
  settings = {
    texlab = {
      build = {
        args = vim.list_extend(default_args, {
          "-outdir=build",
          "-pdflatex=xelatex",
        }),
        onSave = true,
      },
    },
  },
}

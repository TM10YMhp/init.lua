return {
  before_init = function(_, config)
    config.settings.texlab.build.args = config.settings.texlab.build.args or {}
    vim.list_extend(config.settings.texlab.build.args, {
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
}

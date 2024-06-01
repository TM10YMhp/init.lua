return {
  "texlab",
  setup = function()
    return {
      settings = {
        texlab = {
          build = {
            args = {
              "-pdf",
              "-interaction=nonstopmode",
              "-synctex=1",
              "%f",
              "-outdir=build",
              "-pdflatex=xelatex",
            },
            onSave = true,
          },
        },
      },
    }
  end,
}

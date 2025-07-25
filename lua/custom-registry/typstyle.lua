-- TODO: Pull Request
return {
  name = "typstyle",
  description = "Beautiful and reliable typst code formatter",
  homepage = "https://github.com/Enter-tainer/typstyle",
  licenses = { "Apache-2.0" },
  languages = { "Typst" },
  categories = { "Formatter" },
  source = {
    id = "pkg:github/Enter-tainer/typstyle@v0.13.13",
    asset = {
      {
        target = "darwin_arm64",
        file = "typstyle-aarch64-apple-darwin",
      },
      {
        target = "darwin_x64",
        file = "typstyle-x86_64-apple-darwin",
      },
      {
        target = "linux_arm64",
        file = "typstyle-aarch64-unknown-linux-gnu",
      },
      {
        target = "linux_x64",
        file = "typstyle-x86_64-unknown-linux-gnu",
      },
      {
        target = "win_x64",
        file = "typstyle-x86_64-pc-windows-msvc.exe",
      },
    },
  },
  bin = {
    typstyle = "{{source.asset.file}}",
  },
}

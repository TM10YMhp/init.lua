-- TODO: update to v1.49
local jdtls_version = "v1.49.0"
local jdtls_hash = "202507311558"
local equinox_version = "1.7.0.v20250519-0528"

local files = {
  ["jdtls.tar.gz"] = 'https://download.eclipse.org/jdtls/milestones/{{ version | strip_prefix "v" }}/jdt-language-server-{{ version | strip_prefix "v" }}-'
    .. jdtls_hash
    .. ".tar.gz",
  ["lombok.jar"] = "https://projectlombok.org/downloads/lombok.jar",
}
return {
  name = "jdtls",
  description = "Java language server.",
  homepage = "https://github.com/eclipse/eclipse.jdt.ls",
  licenses = { "EPL-2.0" },
  languages = { "Java" },
  categories = { "LSP" },
  source = {
    id = "pkg:generic/eclipse/eclipse.jdt.ls@" .. jdtls_version,
    download = {
      {
        target = { "darwin_x64", "darwin_arm64" },
        files = files,
        config = "config_mac/",
      },
      {
        target = "linux",
        files = files,
        config = "config_linux/",
      },
      {
        target = "win",
        files = files,
        config = "config_win/",
      },
    },
  },
  schemas = {
    lsp = "vscode:https://raw.githubusercontent.com/redhat-developer/vscode-java/master/package.json",
  },
  bin = {
    jdtls = "python:bin/jdtls",
  },
  share = {
    ["jdtls/plugins/org.eclipse.equinox.launcher.jar"] = "plugins/org.eclipse.equinox.launcher_"
      .. equinox_version
      .. ".jar",
    ["jdtls/plugins/"] = "plugins/",
    ["jdtls/config/"] = "{{source.download.config}}",
    ["jdtls/lombok.jar"] = "lombok.jar",
  },
  neovim = {
    lspconfig = "jdtls",
  },
}

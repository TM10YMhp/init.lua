<div align="center">

# TM10YMhp's init.lua

Arranque rapido, bajo consumo de memoria, y carga diferida gracias a [💤 lazy.nvim](https://github.com/folke/lazy.nvim).

Elija el fragmento de código que comprenda totalmente.

Siempre en WIP 🏗

<!-- screenshot -->

![screenshot](https://github.com/TM10YMhp/dotfiles/blob/master/images/screenshot.png)

<sub>Para conocer el esquema de colores, consulte [serene.nvim](https://github.com/TM10YMhp/serene.nvim). Para ver más presentaciones, consulte la sección [presentaciones].</sub>

</div>

## 💡 ¿Encontraste un problema o tienes una sugerencia?

Si encuentra algun problema o tiene alguna sugerencia, por favor abre un issue y estare encantado de discutirlo contigo.

## ✨ Caracteristicas

- 🚀 Increiblemente rapido.
- 💤 VeryLazy, complementos cargados muy perezosamente gracias a [lazy.nvim](https://github.com/folke/lazy.nvim).
- 📦 Gran cantidad de complementos preconfigurados y listos para usar.

## ⚡️ Requisitos previos

- neovim >= 0.10.0 (debe construirse con LuaJIT)
- git >= 2.19.0 (para soporte de clones parciales)
- node >= 20.10.0
- curl >= 8.4.0
- un compilador **C** para `nvim-treesitter`. Mira [aquí](https://github.com/nvim-treesitter/nvim-treesitter#requirements)
- para `telescope.nvim`
  - [ripgrep](https://github.com/BurntSushi/ripgrep) >= 13.0.0
  - [make]() para `telescope-fzf-native.nvim`. Mira [aqui]()
- para `rest.nvim` **(opcional)**
  - [jq](https://github.com/jqlang/jq)
  - [tidy](https://github.com/htacg/tidy-html5)

## 🚀 Empezando

### 1. Descargar configuracion

- Eliminar archivos de Neovim actuales

```bash
# recomendado

## Windows
rm -rf ~/AppData/Local/nvim/
## Linux
rm -rf ~/.config/nvim/

# opcional pero recomendado

## Windows
rm -rf ~/AppData/Local/nvim-data/
## Linux
rm -rf ~/.local/share/nvim/
rm -rf ~/.local/state/nvim/
rm -rf ~/.cache/nvim/
```

- Posicionarse en el directorio

```bash
# Windows
cd ~/AppData/Local/
# Linux
cd ~/.config/
```

- Clonar repositorio

```
git clone -b dev https://github.com/TM10YMhp/init.lua.git nvim
```

- Elimina la carpeta `.git` para que puedas agregarla a tu propio repositorio más tarde

```
rm -rf .git/
```

- ¡Inicie Neovim!

```
nvim
```

### 2. Instalar complementos

Luego de iniciar neovim espere a que `lazy.nvim` instale todos los complementos y finalmente reinicie neovim.

<details><summary>Lista de complementos</summary>

- LuaSnip
- [debugloop/telescope-undo.nvim](https://github.com/debugloop/telescope-undo.nvim)
- [echasnovski/mini.completion](https://github.com/echasnovski/mini.completion)
- [folke/lazy.nvim](https://github.com/folke/lazy.nvim)
- [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim)
- [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround)
- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [numToStr/Comment.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [ojroques/nvim-osc52](https://github.com/ojroques/nvim-osc52)
- [voldikss/vim-floaterm](https://github.com/voldikss/vim-floaterm)
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
- cellular-automaton.nvim
- cloak.nvim
- cmp-buffer
- cmp-nvim-lsp
- cmp_luasnip
- codeium.vim
- conform.nvim
- diffview.nvim
- fidget.nvim
- friendly-snippets
- harpoon
- indent-o-matic
- mini.ai
- mini.align
- mini.bracketed
- mini.files
- mini.jump
- mini.jump2d
- mini.move
- mini.tabline
- mini.trailspace
- mru
- nvim-autopairs
- nvim-cmp
- nvim-cmp-buffer-lines
- nvim-early-retirement
- nvim-lint
- nvim-tree.lua
- nvim-treesitter
- nvim-treesitter-endwise
- nvim-ts-autotag
- nvim-ts-context-commentstring
- nvim-ufo
- nvim-various-textobjs
- obsidian.nvim
- playground
- plenary.nvim
- pomo.nvim
- project.nvim
- promise-async
- rest.nvim
- rose-pine
- scrollEOF.nvim
- serene.nvim
- solarized-osaka.nvim
- statuscol.nvim
- telescope-live-grep-args.nvim
- telescope-mru.nvim
- telescope-symbols.nvim
- telescope-ui-select.nvim
- treesj
- trouble.nvim
- vim-be-good
- vim-cool
- vim-fugitive
- vscode.nvim
- window-picker

</details>

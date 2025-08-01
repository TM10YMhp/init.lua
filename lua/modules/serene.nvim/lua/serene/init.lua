local M = {}

local c = {
  darkred = 160,
  gray = 250,
  darkgray = 242,
  cyan = 45,
  darkyellow = 214,
  cursor = 235,

  red = 52,
  green = 22,
  change = 233,
  text = 23,

  lightgreen = 34,
}

local g = {
  darkred = "#d70000",
  gray = "#bcbcbc",
  darkgray = "#6c6c6c",
  cyan = "#00d7ff",
  darkyellow = "#ffaf00",
  cursor = "#262626",

  red = "#5f0000",
  green = "#005f00",
  change = "#121212",
  text = "#005f5f",

  lightgreen = "#00af00",
}

function M.set_groups()
  -- stylua: ignore
  local groups = {
    Normal           = {},
    NormalFloat      = { link    = "Normal" },
    NonText          = { ctermfg = c.darkgray, fg = g.darkgray },
    Comment          = { ctermfg = c.gray, fg = g.gray },
    Conceal          = {},
    TabLine          = { link    = "Comment" },
    TabLineSel       = {},
    TabLineFill      = {},
    Constant         = {},
    Identifier       = {},
    Statement        = {},
    PreProc          = {},
    Type             = {},
    Special          = {},
    Underlined       = {},
    Ignore           = {},
    Todo             = { link    = "Comment" },
    WildMenu         = {},
    StatusLine       = {},
    StatusLineNC     = { link    = "Comment" },
    StatusLineTerm   = { link    = "StatusLine" },
    StatusLineTermNC = { link    = "StatusLineNC" },
    Search           = { ctermfg = c.darkyellow, fg = g.darkyellow, reverse = true },
    IncSearch        = { link    = "Visual" },
    CurSearch        = { link    = "IncSearch" },
    Substitute       = { link    = "DiffText" },
    LineNr           = {},
    Cursor           = { reverse = true },
    CursorLine       = { ctermbg = c.cursor, bg = g.cursor },
    CursorLineFold   = {},
    CursorLineSign   = {},
    CursorLineNr     = { ctermbg = 237, bg = "#3a3a3a" }, -- no link
    CursorColumn     = { link    = "CursorLine" },
    FoldColumn       = { link    = "LineNr" },
    Folded           = {},
    Visual           = { reverse = true },
    VisualNOS        = { link    = "Visual" },
    ColorColumn      = { ctermbg = c.darkgray, bg = g.darkgray },
    SignColumn       = {},
    MatchParen       = { reverse = true },
    Title            = {},
    WinBar           = {},
    WinBarNC         = {},
    Directory        = {},
    SpecialKey       = { link = "NonText" },

    Error            = { ctermfg = c.darkred, fg = g.darkred },
    ErrorMsg         = { ctermfg = c.darkred, fg = g.darkred },
    WarningMsg       = { ctermfg = c.darkyellow, fg = g.darkyellow },

    Pmenu            = { link = "CursorLine" },
    PmenuThumb       = { link = "ColorColumn" },
    PmenuSel         = { link = "Visual" },
    PmenuSbar        = { link = "Pmenu" },
    PmenuMatch       = {},
    PmenuMatchSel    = {},
    PmenuExtra       = { link = "NonText" },

    QuickFixLine     = { link = "CursorLine" },
    ModeMsg          = {},
    MoreMsg          = { ctermfg = c.cyan, fg = g.cyan },
    Question         = { link    = "MoreMsg" },

    LspSignatureActiveParameter = { link = "Comment" },

    -- fzf-lua
    FzfLuaFzfMatch     = { link = "IncSearch" },
    FzfLuaCursor       = { link = "IncSearch" },
    FzfLuaFzfInfo      = { link = "Comment" },
    FzfLuaFzfPrompt    = { link = "Comment" },
    FzfLuaFzfHeader    = { link = "Comment" },
    FzfLuaFzfSeparator = { link = "Comment" },

    -- Diff
    Added      = { ctermfg = c.lightgreen, fg = g.lightgreen },
    Changed    = { ctermfg = c.cyan, fg = g.cyan },
    Removed    = { ctermfg = c.darkred, fg = g.darkred },

    DiffAdd    = { ctermbg = c.green, bg = g.green },
    DiffChange = { ctermbg = c.change, bg = g.change },
    DiffDelete = { ctermbg = c.red, bg = g.red },
    DiffText   = { ctermbg = c.text, bg = g.text },

    diffAdded   = { link = "DiffAdd" },
    diffChanged = { link = "DiffChange" },
    diffRemoved = { link = "DiffDelete" },

    ["@diff.plus"]  = { link = "DiffAdd" },
    ["@diff.delta"] = { link = "DiffChange" },
    ["@diff.minus"] = { link = "DiffDelete" },

    -- DiffView
    DiffviewStatusDeleted       = { nocombine = true },
    DiffviewFilePanelTitle      = { nocombine = true },
    DiffviewFilePanelCounter    = { nocombine = true },
    DiffviewFilePanelRootPath   = { nocombine = true },
    DiffviewFilePanelInsertions = { ctermfg = c.lightgreen, fg = g.lightgreen },
    DiffviewFilePanelSelected   = { link = "Comment" },
    DiffviewFilePanelDeletions  = { link = "ErrorMsg" },
    DiffviewHash                = { link = "WarningMsg" },
    DiffviewReference           = { link = "MoreMsg" },

    -- flash
    FlashLabel = { ctermfg = c.cyan, fg = g.cyan, reverse = true },

    -- Mini
    MiniTrailspace = { ctermbg = c.darkred, bg = g.darkred },

    -- mason
    MasonHighlightBlockBold = { reverse = true },
    MasonMutedBlock = { link = "Comment" },
    MasonHeader     = { nocombine = true },
    MasonHighlight  = { nocombine = true },

    DiagnosticError = {},
    DiagnosticWarn  = {},
    DiagnosticInfo  = {},
    DiagnosticHint  = {},
    DiagnosticOk    = {},

    -- NvimUfo
    UfoFoldedFg          = {},
    UfoFoldedEllipsis    = { link = "NonText" },
    UfoPreviewCursorLine = { link = "CursorLine" },
    UfoPreviewWinBar     = { link = "CursorLine"},

    -- blink
    BlinkCmpMenu          = { nocombine = true },
    BlinkCmpMenuBorder    = { nocombine = true },
    BlinkCmpMenuSelection = { link = "CursorLine" },
    BlinkCmpKind          = { link = "Comment" },
    BlinkCmpLabelMatch    = { ctermfg = c.cyan, fg = g.cyan },

    -- GitSigns
    GitSignsAddInline    = { link = "DiffText" },
    GitSignsDeleteInline = { link = "DiffChange" },

    GitSignsAdd          = { nocombine = true },
    GitSignsChange       = { nocombine = true },
    GitSignsDelete       = { nocombine = true },
    GitSignsTopdelete    = { nocombine = true },
    GitSignsChangedelete = { nocombine = true },
    GitSignsUntracked    = { nocombine = true },

    -- snacks
    SnacksNotifierIconInfo    = { link = "Comment" },
    SnacksNotifierTitleInfo   = { link = "Comment" },
    SnacksNotifierBorderInfo  = { link = "Comment" },

    SnacksNotifierIconWarn    = { link = "WarningMsg" },
    SnacksNotifierTitleWarn   = { link = "WarningMsg" },
    SnacksNotifierBorderWarn  = { link = "WarningMsg" },

    SnacksNotifierIconDebug   = { link = "Comment" },
    SnacksNotifierTitleDebug  = { link = "Comment" },
    SnacksNotifierBorderDebug = { link = "Comment" },

    SnacksNotifierIconError   = { link = "ErrorMsg" },
    SnacksNotifierTitleError  = { link = "ErrorMsg" },
    SnacksNotifierBorderError = { link = "ErrorMsg" },

    SnacksNotifierIconTrace   = { link = "Comment" },
    SnacksNotifierTitleTrace  = { link = "Comment" },
    SnacksNotifierBorderTrace = { link = "Comment" },

    SnacksPickerTree           = { link = "NonText" },
    SnacksPickerListCursorLine = { link = "CursorLine" },

    -- nvim-tree
    NvimTreeIndentMarker     = { link = "NonText" },
    NvimTreeImageFile        = { nocombine = true },
    NvimTreeExecFile         = { nocombine = true },
    NvimTreeGitFileIgnoredHL = { nocombine = true },
    NvimTreeCopiedHL         = { link = "DiffAdd" },
    NvimTreeCutHL            = { link = "DiffText" },
    NvimTreeWindowPicker     = { link = "PmenuThumb" },

    -- treesitter-context
    TreesitterContext           = { link = "NonText" },
    TreesitterContextLineNumber = { link = "NonText" },

    -- extras
    String        = {},
    Function      = {},
    Delimiter     = {},
    Operator      = {},
    ["@variable"] = {},
    ["@string.documentation"] = { link = "Comment" },
  }

  for group, hl in pairs(groups) do
    vim.api.nvim_set_hl(0, group, hl)
  end
end

function M.autocmds()
  local group = vim.api.nvim_create_augroup("serene", { clear = true })

  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function()
      if vim.g.colors_name == "serene" then return end

      vim.api.nvim_set_hl(0, "TelescopeMatching", { link = "Special" })
      vim.api.nvim_set_hl(0, "TelescopeSelection", { link = "Visual" })
      vim.api.nvim_set_hl(0, "TelescopeCounter", { link = "NonText" })
      vim.api.nvim_set_hl(0, "TelescopePromptCounter", { link = "NonText" })
    end,
  })
end

function M.load()
  if vim.g.colors_name then vim.cmd("hi clear") end

  vim.o.termguicolors = true
  vim.g.colors_name = "serene"

  M.set_groups()
  -- M.autocmds()
end

return M

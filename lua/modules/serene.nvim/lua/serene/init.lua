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
    FzfLuaFzfMatch      = { link = "IncSearch" },
    FzfLuaCursor        = { link = "IncSearch" },
    FzfLuaFzfInfo       = { link = "Comment" },
    FzfLuaFzfPrompt     = { link = "Comment" },
    FzfLuaFzfHeader     = { link = "Comment" },
    FzfLuaFzfSeparator  = { link = "Comment" },

    -- Diff
    ["@diff.delta"] = { link = "DiffChange" },
    ["@diff.minus"] = { link = "DiffDelete" },
    ["@diff.plus"]  = { link = "DiffAdd" },

    diffAdded   = { link = "DiffAdd" },
    diffChanged = { link = "DiffChange" },
    diffRemoved = { link = "DiffDelete" },

    DiffDelete = { ctermbg = c.red, bg = g.red },
    DiffAdd    = { ctermbg = c.green, bg = g.green },
    DiffChange = { ctermbg = c.change, bg = g.change },
    DiffText   = { ctermbg = c.text, bg = g.text },

    Added       = { ctermfg = c.lightgreen, fg = g.lightgreen },
    Changed     = { ctermfg = c.cyan, fg = g.cyan },
    Removed     = { ctermfg = c.darkred, fg = g.darkred },

    -- DiffView
    DiffviewFilePanelTitle      = { nocombine = true },
    DiffviewFilePanelCounter    = { nocombine = true },
    DiffviewFilePanelRootPath   = { nocombine = true },
    DiffviewFilePanelSelected   = { link = "Comment" },
    DiffviewFilePanelInsertions = { ctermfg = c.lightgreen, fg = g.lightgreen },
    DiffviewFilePanelDeletions  = { link = "ErrorMsg" },
    DiffviewHash                = { link = "WarningMsg" },
    DiffviewReference           = { link = "MoreMsg" },
    DiffviewStatusDeleted       = { nocombine = true },

    -- flash
    FlashLabel   = { ctermfg = c.cyan, fg = g.cyan, reverse = true },

    -- Mini
    MiniTrailspace = { ctermbg = c.darkred, bg = g.darkred },
    MiniCompletionActiveParameter = { link = "Comment" },
    MiniCursorWord = { ctermfg = c.darkyellow, fg = g.darkyellow },

    -- mason
    MasonMutedBlock         = { link    = "Comment" },
    MasonHighlightBlockBold = { reverse = true },
    MasonHeader    = { nocombine = true },
    MasonHighlight = { nocombine = true },

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

    -- cmp
    CmpGhostText       = { link = "NonText" },

    CmpItemKind        = { link = "Comment" },
    CmpItemMenu        = { link = "Comment" },

    CmpItemKindCodeium = { link = "Comment" },
    CmpItemKindCopilot = { link = "Comment" },
    CmpItemKindTabNine = { link = "Comment" },

    -- blink
    BlinkCmpMenu             = { nocombine = true },
    BlinkCmpMenuBorder       = { nocombine = true },
    BlinkCmpMenuSelection    = { link = "CursorLine" },
    BlinkCmpKind             = { link = "Comment" },
    BlinkCmpKindCodeium      = { link = "BlinkCmpKind" },
    BlinkCmpLabelMatch       = { ctermfg = c.cyan, fg = g.cyan },

    -- Git Messenger
    diffAdded   = { link = "DiffAdd" },
    diffRemoved = { link = "DiffDelete" },

    -- GitSigns
    GitSignsAddInline     = { link = "DiffText" },
    GitSignsDeleteInline  = { link = "DiffChange" },

    GitSignsAdd          = { nocombine = true },
    GitSignsChange       = { nocombine = true },
    GitSignsDelete       = { nocombine = true },
    GitSignsTopdelete    = { nocombine = true },
    GitSignsChangedelete = { nocombine = true },
    GitSignsUntracked    = { nocombine = true },

    -- GitSignsStagedAdd          = { link = "NonText" },
    -- GitSignsStagedChange       = { link = "NonText" },
    -- GitSignsStagedDelete       = { link = "NonText" },
    -- GitSignsStagedTopdelete    = { link = "NonText" },
    -- GitSignsStagedChangedelete = { link = "NonText" },

    -- snacks
    SnacksNotifierIconInfo    = { link = "Comment" },
    SnacksNotifierIconWarn    = { link = "WarningMsg" },
    SnacksNotifierIconDebug   = { link = "Comment" },
    SnacksNotifierIconError   = { link = "ErrorMsg" },
    SnacksNotifierIconTrace   = { link = "Comment" },

    SnacksNotifierTitleInfo   = { link = "Comment" },
    SnacksNotifierTitleWarn   = { link = "WarningMsg" },
    SnacksNotifierTitleDebug  = { link = "Comment" },
    SnacksNotifierTitleError  = { link = "ErrorMsg" },
    SnacksNotifierTitleTrace  = { link = "Comment" },

    SnacksNotifierBorderInfo  = { link = "Comment" },
    SnacksNotifierBorderWarn  = { link = "WarningMsg" },
    SnacksNotifierBorderDebug = { link = "Comment" },
    SnacksNotifierBorderError = { link = "ErrorMsg" },
    SnacksNotifierBorderTrace = { link = "Comment" },

    SnacksPickerTree           = { link = "NonText" },
    SnacksPickerListCursorLine = { link = "CursorLine" },

    -- NvimWindowPicker
    WindowPickerStatusLine   = { link = "PmenuSel" },
    WindowPickerStatusLineNC = { link = "PmenuThumb" },
    WindowPickerWinBar       = { link = "PmenuSel" },
    WindowPickerWinBarNC     = { link = "PmenuThumb" },

    -- bufferline
    BufferLineBackground   = { link = "Comment" },
    BufferLineTab          = { link = "Comment" },
    BufferLineTabSeparator = { link = "Comment" },
    BufferLineTabSelected  = {},

    BufferLineBuffer            = { link = "Comment" },
    BufferLineDuplicate         = { link = "Comment" },
    BufferLineModified          = { link = "Comment" },
    BufferLineErrorDiagnostic   = { link = "Comment" },
    BufferLineError             = { link = "Comment" },
    BufferLineHintDiagnostic    = { link = "Comment" },
    BufferLineHint              = { link = "Comment" },
    BufferLineInfoDiagnostic    = { link = "Comment" },
    BufferLineInfo              = { link = "Comment" },
    BufferLineWarningDiagnostic = { link = "Comment" },
    BufferLineWarning           = { link = "Comment" },

    BufferLineBufferVisible            = {},
    BufferLineDuplicateVisible         = {},
    BufferLineModifiedVisible          = {},
    BufferLineErrorDiagnosticVisible   = {},
    BufferLineErrorVisible             = {},
    BufferLineHintDiagnosticVisible    = {},
    BufferLineHintVisible              = {},
    BufferLineInfoDiagnosticVisible    = {},
    BufferLineInfoVisible              = {},
    BufferLineWarningDiagnosticVisible = {},
    BufferLineWarningVisible           = {},

    -- nvim-tree
    NvimTreeIndentMarker       = { link = "NonText" },
    NvimTreeImageFile          = { nocombine = true },
    NvimTreeExecFile           = { nocombine = true },
    NvimTreeGitFileIgnoredHL   = { nocombine = true },
    NvimTreeCopiedHL           = { link = "DiffAdd" },
    NvimTreeCutHL              = { link = "DiffText" },
    NvimTreeWindowPicker       = { link = "PmenuThumb" },

    -- neo-tree
    NeoTreeTabActive            = { nocombine = true },
    NeoTreeRootName             = { nocombine = true },
    NeoTreeDotfile              = { nocombine = true },
    NeoTreeCursorLine           = { link = "CursorLine" },
    NeoTreeTabInactive          = { link = "Comment" },
    NeoTreeTabSeparatorActive   = { link = "Comment" },
    NeoTreeTabSeparatorInactive = { link = "Comment" },
    NeoTreeDimText              = { nocombine = true },

    NeoTreeFileStatsHeader      = { nocombine = true },
    NeoTreeFileStats            = { nocombine = true },

    NeoTreeGitModified          = { nocombine = true },
    NeoTreeGitConflict          = { nocombine = true },

    NeoTreeGitUntracked         = { nocombine = true },
    NeoTreeGitDeleted           = { nocombine = true },
    NeoTreeGitAdded             = { nocombine = true },

    NeoTreeFloatBorder          = { nocombine = true },
    NeoTreeModified             = { nocombine = true },
    NeoTreeMessage              = { link = "WarningMsg" },

    -- treesitter-context
    TreesitterContext           = { link = "NonText" },
    TreesitterContextLineNumber = { link = "NonText" },

    -- extras
    String        = {},
    Function      = {},
    Delimiter     = {},
    Operator      = {},
    ["@variable"] = {},
    ["@string.documentation"] = { link="Comment" },
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

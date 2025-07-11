-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#completionItemKind

---@class serenenvim.util.cmp
local M = {}

---@module "cmp"

---@type fun(entry: cmp.Entry, vim_item: vim.CompletedItem):vim.CompletedItem
M.format = function(_, item)
  item.kind = SereneNvim.config.icons.kinds[item.kind] or "?"
  return item
end

-- https://www.reddit.com/r/neovim/comments/1f5qs07/how_to_show_parameters_of_function_in_cmp/?share_id=ywg6jz-REQG3vKoHNfTRK&utm_content=1&utm_medium=android_app&utm_name=androidcss&utm_source=share&utm_term=1
-- https://www.reddit.com/r/neovim/comments/1ca4gm2/colorful_cmp_menu_powered_by_treesitter/

---@type fun(entry: cmp.Entry, vim_item: vim.CompletedItem):vim.CompletedItem
M.format_complete = function(entry, item)
  local kind = item.kind

  item.kind = SereneNvim.config.icons.kinds[item.kind] or item.kind

  -- Add color to the item
  local color_item =
    require("nvim-highlight-colors").format(entry, { kind = kind })
  if color_item.abbr_hl_group then
    item.kind_hl_group = color_item.abbr_hl_group
    item.kind = color_item.abbr
  end

  if vim.bo.filetype == "java" then
    local item_kind = entry:get_kind() --- @type lsp.CompletionItemKind | number
    if item_kind == 4 or item_kind == 3 or item_kind == 2 then -- Function/Method/Constructor
      local completion_item = entry:get_completion_item()
      local label_detail = completion_item.labelDetails

      if label_detail then
        local detail = label_detail.detail
        local description = label_detail.description

        if detail then
          item.abbr = item.abbr
            .. detail
            .. (description and ": " .. description or "")
        end
      end
    end
  end

  if
    vim.list_contains(
      { "typescriptreact", "javascript", "typescript", "javascriptreact" },
      vim.o.filetype
    )
  then
    local item_kind = entry:get_kind() --- @type lsp.CompletionItemKind | number
    -- item.abbr = item.abbr .. " | " .. item_kind

    if item_kind == 6 or item_kind == 5 or item_kind == 3 or item_kind == 2 then -- Variable/Field/Function/Method
      local completion_item = entry:get_completion_item()

      local data = completion_item.data
      local entryNames = type(data) == "table" and data.entryNames
      local source = entryNames and entryNames[1].source

      local detail = completion_item.detail

      if source then
        item.abbr = item.abbr .. " [" .. source .. "]"
      elseif detail and not entryNames then
        item.abbr = item.abbr .. " [" .. detail .. "]"
      end
    end
  end

  -- item.menu = SereneNvim.config.icons.sources[entry.source.name]
  --   or "[" .. entry.source.name .. "]"
  item.menu = ""

  local function trim(text)
    local max = math.floor(0.35 * vim.o.columns)
    if text and text:len() > max then
      return text:sub(1, max) .. "…"
    else
      local padding = string.rep(" ", 5 - text:len())
      return text .. padding
    end
  end

  item.abbr = trim(item.abbr)

  return item
end

return M

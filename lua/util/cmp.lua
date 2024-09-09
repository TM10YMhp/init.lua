---@class serenenvim.util.cmp
local M = {}

---@module "cmp"

---@type fun(entry: cmp.Entry, vim_item: vim.CompletedItem):vim.CompletedItem
M.format = function(_, item)
  item.kind = SereneNvim.config.icons.kinds[item.kind] or "?"
  return item
end

---@type fun(entry: cmp.Entry, vim_item: vim.CompletedItem):vim.CompletedItem
M.format_complete = function(entry, item)
  item.kind = SereneNvim.config.icons.kinds[item.kind] or "?"

  if vim.bo.filetype == "java" then
    local item_kind = entry:get_kind() --- @type lsp.CompletionItemKind | number
    if item_kind == 3 or item_kind == 2 then -- Function/Method
      local completion_item = entry:get_completion_item()
      local label_detail = completion_item.labelDetails

      if label_detail then
        local detail = label_detail.detail
        local description = label_detail.description
        if detail and description then
          item.abbr = item.abbr .. detail .. ": " .. description
        end
      end
    end
  end

  item.menu = "["
    .. (SereneNvim.config.icons.sources[entry.source.name] or entry.source.name)
    .. "]"

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

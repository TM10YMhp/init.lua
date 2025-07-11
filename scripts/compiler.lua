print("Compiling...")

local filenames = {
  "plugins/bufferline",
  "plugins/cmp",
  "plugins/colorscheme",
  "plugins/comment",
  "plugins/conform",
  "plugins/diffview",
  "plugins/flash",
  "plugins/floaterm",
  "plugins/fugitive",
  "plugins/gitsigns",
  "plugins/harpoon",
  "plugins/init",
  "plugins/lsp",
  "plugins/lualine",
  "plugins/mini",
  "plugins/nvim_lint",
  "plugins/nvim_surround",
  "plugins/nvim_ufo",
  "plugins/nvim_various_textobjs",
  "plugins/perf",
  "plugins/telescope",
  "plugins/treesitter",

  "plugins/extras/cloak",
  "plugins/extras/codeium",
  "plugins/extras/dashboard",
  "plugins/extras/devdocs",
  "plugins/extras/dressing",
  "plugins/extras/markdown_preview",
  "plugins/extras/mini_files",
  "plugins/extras/neo_tree",
  "plugins/extras/noice",
  "plugins/extras/nvim_bqf",
  "plugins/extras/nvim_notify",
  "plugins/extras/obsidian",
  "plugins/extras/project",
  "plugins/extras/rest",
  "plugins/extras/trouble",
}

local function getFilenames(names)
  local _filenames = {}
  for _, name in ipairs(names) do
    table.insert(_filenames, "lua/" .. name .. ".lua")
  end
  return _filenames
end

local output_name = "lua/output_compiler.lua"
local output = io.open(output_name, "w")

if not output then
  print("output not found")
  return
end

local content_before = {}
local content_after = {}

for _, input_name in ipairs(getFilenames(filenames)) do
  local content = {}
  local input = io.open(input_name, "r")

  if input then
    local length = input:lines()
    for line in input:lines() do
      if line:match("^return ") then line = line:gsub("^return ", "") end

      if line ~= "" then
        table.insert(content, "  " .. line)
      else
        table.insert(content, line)
      end
    end

    content[#content] = content[#content]:gsub("}", "},")

    local before = true
    for _, line in ipairs(content) do
      if line:match("^  {") then before = false end

      if before then
        table.insert(content_before, line)
      else
        table.insert(content_after, line)
      end
    end

    input:close()
  else
    print("input not found")
  end
end

for _, line in ipairs(content_before) do
  output:write(line .. "\n")
end

output:write("return {" .. "\n")

for _, line in ipairs(content_after) do
  output:write(line .. "\n")
end

output:write("}" .. "\n")

output:close()
print("Done!")

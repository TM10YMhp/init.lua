---@diagnostic disable
-- http://lua-users.org/wiki/RandomStrings
local Chars = {}
for Loop = 0, 255 do
  Chars[Loop + 1] = string.char(Loop)
end
local String = table.concat(Chars)

local Built = { ["."] = Chars }

local AddLookup = function(CharSet)
  local Substitute = string.gsub(String, "[^" .. CharSet .. "]", "")
  local Lookup = {}
  for Loop = 1, string.len(Substitute) do
    Lookup[Loop] = string.sub(Substitute, Loop, Loop)
  end
  Built[CharSet] = Lookup

  return Lookup
end

function string.random(Length, CharSet)
  -- Length (number)
  -- CharSet (string, optional); e.g. %l%d for lower case letters and digits

  local CharSet = CharSet or "."

  if CharSet == "" then
    return ""
  else
    local Result = {}
    local Lookup = Built[CharSet] or AddLookup(CharSet)
    local Range = #Lookup

    for Loop = 1, Length do
      Result[Loop] = Lookup[math.random(1, Range)]
    end

    return table.concat(Result)
  end
end

-- http://lua-users.org/wiki/DemoScripts
-- Curried fripperies
put_in = function(t)
  local f
  f = function(k)
    if k then
      t[k] = true
      return f
    else
      return
    end -- if
  end -- function
  return f
end -- function
bag, enough = {}
put_in(bag)("wibble")(57)("grumpkin")("foo")(enough)
for k, v in pairs(bag) do
  print("bag has", k, "?", v)
end

--- the classic recursive example:
function factorial(n)
  if n == 0 then
    return 1
  else
    return n * factorial(n - 1)
  end
end

io.write("factorial of 10 is ", factorial(10), "\n")

-- and its tail recursive variant
fact = function(n)
  local f
  f = function(m, a)
    if m == 0 then
      return a
    end -- if
    return f(m - 1, m * a)
  end -- function
  return f(n, 1)
end -- function
print("factorial of 10 is ", fact(10))

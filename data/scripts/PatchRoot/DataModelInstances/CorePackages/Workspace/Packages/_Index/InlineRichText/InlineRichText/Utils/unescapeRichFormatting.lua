-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:11:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    ["&lt;"] = "<",
    ["&gt;"] = ">",
    ["&quot;"] = "\"",
    ["&apos;"] = "'",
    ["&amp;"] = "&"
}

local function unescapeRichFormatting(str1: string)
    return (str1:gsub("&%l+;", tbl1))
end

return unescapeRichFormatting

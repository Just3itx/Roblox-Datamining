-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T14:50:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    ["&"] = "&amp;",
    ["<"] = "&lt;",
    [">"] = "&gt;",
    ["\""] = "&quot;",
    ["'"] = "&apos;"
}

local function escapeRichText(str1: string)
    return (string.gsub(str1, "[&<>\"']", tbl1))
end

return escapeRichText

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:50:35Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { ["<"] = "&lt;", [">"] = "&gt;", ["\""] = "&quot;", ["'"] = "&apos;" }

local function escapeRichText(str1: string)
    local var1 = string.gsub(str1, "&", "&amp;")
    for value, value2 in tbl1 do
        var1 = string.gsub(var1, value, value2)
    end
    return var1
end

return escapeRichText

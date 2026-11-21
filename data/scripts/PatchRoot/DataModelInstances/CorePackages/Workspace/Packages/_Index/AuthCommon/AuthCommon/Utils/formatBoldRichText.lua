-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T00:50:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { ["<"] = "&lt;", [">"] = "&gt;", ["\""] = "&quot;", ["'"] = "&apos;" }

local function formatBoldRichText(str1: string): string
    local var1 = string.gsub(str1, "&", "&amp;")
    for value, value2 in tbl1 do
        var1 = string.gsub(var1, value, value2)
    end
    return `<b>{var1}</b>`
end

return formatBoldRichText

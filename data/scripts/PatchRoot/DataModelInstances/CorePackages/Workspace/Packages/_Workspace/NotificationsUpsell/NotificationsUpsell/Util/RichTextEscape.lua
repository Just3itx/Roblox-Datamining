-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:40:58Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = { ["<"] = "&lt;", [">"] = "&gt;", ["\""] = "&quot;", ["'"] = "&apos;" }

return function(str1: string)
    local var1 = str1:gsub("&", "&amp;")
    for k, value in pairs(tbl1) do
        var1 = var1:gsub(k, value)
    end
    return var1
end

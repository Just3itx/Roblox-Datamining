-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T21:11:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function matchesSearchQuery(str1: string?, str2: string): boolean
    if str2 == "" then
        return true
    end
    if str1 == nil or str1 == "" then
        return false
    end
    local str3 = string.lower(str2)
    local str4 = string.lower(str1)
    return string.find(str4, str3, 1, true) ~= nil
end

return matchesSearchQuery

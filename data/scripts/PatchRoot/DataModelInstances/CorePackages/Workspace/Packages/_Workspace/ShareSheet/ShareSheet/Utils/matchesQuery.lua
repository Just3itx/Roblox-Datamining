-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T14:51:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function matchesQuery(str1: string, ...)
    for _, value in { ... } do
        if string.find(string.lower(value), str1, 1, true) ~= nil then
            return true
        end
    end
    return false
end

return matchesQuery

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T19:51:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function toUnifiedCategoryId(str1: string?)
    if str1 ~= nil then
        return tonumber(str1)
    end

    return nil
end

return toUnifiedCategoryId

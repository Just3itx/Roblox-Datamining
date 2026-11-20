-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:10:36Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getTestIdTag(str1: string?, str2: string?)
    if str1 == nil then
        return nil
    elseif str2 then
        return `data-testid={str1}--{str2}`
    end

    return `data-testid={str1}`
end

return getTestIdTag

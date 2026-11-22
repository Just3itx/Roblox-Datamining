-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:31:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function resolveEnumItem(str1: string, str2: string)
    local success, result = pcall(function()
        return Enum[str1][str2]
    end)
    return if success then result else nil
end

return resolveEnumItem

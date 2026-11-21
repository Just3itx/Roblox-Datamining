-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function formatExperienceIcon(str1: string?, str2: string): string
    if str1 then
        return str1
    end
    return `rbxthumb://type=GameIcon&id={str2}&w=150&h=150`
end

return formatExperienceIcon

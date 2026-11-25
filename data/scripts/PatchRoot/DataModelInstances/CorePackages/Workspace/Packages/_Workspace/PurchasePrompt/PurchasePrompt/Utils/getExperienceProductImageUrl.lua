-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:51:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getExperienceProductImageUrl(str1: string?, id): string
    if str1 and str1 ~= "" then
        return str1
    end
    return string.format("rbxthumb://type=GameIcon&id=%s&w=150&h=150", tostring(id))
end

return getExperienceProductImageUrl

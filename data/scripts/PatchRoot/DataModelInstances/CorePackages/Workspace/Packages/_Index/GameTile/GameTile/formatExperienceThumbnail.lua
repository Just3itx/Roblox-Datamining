-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:20Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function formatExperienceThumbnail(str1: string?, str2: string, bool1: boolean?): string
    local num1, num2

    if bool1 then
        num1 = 768
        num2 = 432
    else
        num1 = 384
        num2 = 216
    end

    if str1 and str1 ~= "0" then
        return `rbxthumb://type=Asset&id={str1}&w={num1}&h={num2}`
    end
    return `rbxthumb://type=GameThumbnail&id={str2}&w={num1}&h={num2}`
end

return formatExperienceThumbnail

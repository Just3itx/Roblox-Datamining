-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function constructGameThumbnailUrl(str1: string, num1: number, num2: number): string
    return `rbxthumb://type=GameThumbnail&id={str1}&w={num1}&h={num2}`
end

return constructGameThumbnailUrl

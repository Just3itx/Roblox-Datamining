-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextService = game:GetService("TextService")

local function measureTextLineCount(string: string, x: number, fontSize: number, font: Enum.Font, num1: number): number
    if string == "" or x <= 0 then
        return 1
    end

    local vector2 = Vector2.new(x, math.huge)
    local textSizeY = TextService:GetTextSize("M", fontSize, font, vector2).Y
    if textSizeY <= 0 then
        return 1
    end

    return math.clamp(math.ceil(TextService:GetTextSize(string, fontSize, font, vector2).Y / textSizeY), 1, num1)
end

return measureTextLineCount

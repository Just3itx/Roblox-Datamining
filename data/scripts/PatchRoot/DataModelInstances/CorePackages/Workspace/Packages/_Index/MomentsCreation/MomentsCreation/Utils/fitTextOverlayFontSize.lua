-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:40:34Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TextService = game:GetService("TextService")

local function wrappedHeight(string: string, fontSize: number, font: Enum.Font, x: number): number -- Luacid: Inlined by compiler; 2 call sites recovered
    return TextService:GetTextSize(string, fontSize, font, Vector2.new(x, 1000000)).Y
end

local function fitTextOverlayFontSize(str1: string, font, num1: number, num2: number, num3: number, num4: number)
    if str1 == "" or num2 <= 0 or num3 <= 0 or num1 <= num4 then
        return num1
    end

    if wrappedHeight(str1, num1, font, num2) <= num3 then
        return num1
    end

    for _ = 1, 8 do
        local fontSize = (num4 + num1) / 2

        if wrappedHeight(str1, fontSize, font, num2) <= num3 then
            num4 = fontSize
        else
            num1 = fontSize
        end
    end

    return num4
end

return fitTextOverlayFontSize

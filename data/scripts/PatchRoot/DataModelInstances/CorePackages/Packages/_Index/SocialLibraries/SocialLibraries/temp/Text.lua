-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T16:01:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local engineFeature = game:GetEngineFeature("TextBoundsRoundUp")

local TextService = game:GetService("TextService")

local module = {
    _TEMP_PATCHED_PADDING = Vector2.new(0, 0)
}
if not engineFeature then
    module._TEMP_PATCHED_PADDING = Vector2.new(2, 2)
end

function module.GetTextBounds(string: string, font: Enum.Font, fontSize: number, frameSize: Vector2)
    return TextService:GetTextSize(string, fontSize, font, frameSize) + module._TEMP_PATCHED_PADDING
end

function module.GetTextWidth(arg1, font, fontSize)
    return module.GetTextBounds(arg1, font, fontSize, Vector2.new(10000, 10000)).X
end

function module.GetTextHeight(arg1, font, fontSize, x: number?)
    return module.GetTextBounds(arg1, font, fontSize, Vector2.new(x, 10000)).Y
end

return module

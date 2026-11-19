-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:51:12Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local GuiService = require(Foundation.Utility.Wrappers).Services.GuiService

local function getGuiInputPosition(vector2: Vector2, arg1)
    local screenGui = arg1:FindFirstAncestorWhichIsA("ScreenGui")
    if not screenGui then
        return vector2
    end

    if not screenGui.IgnoreGuiInset then
        return vector2
    end

    local screenInsets = if screenGui.ScreenInsets == Enum.ScreenInsets.DeviceSafeInsets then Enum.ScreenInsets.DeviceSafeInsets else Enum.ScreenInsets.None
    return vector2 + GuiService:GetInsetArea(screenInsets).Min
end

return getGuiInputPosition

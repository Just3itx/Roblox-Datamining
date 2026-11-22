-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T14:00:49Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local function toGuiSpace(vector2: Vector2, arg1)
    local screenGui = arg1:FindFirstAncestorWhichIsA("ScreenGui")
    return if screenGui == nil or not screenGui.IgnoreGuiInset then vector2 else vector2 + GuiService:GetGuiInset()
end

return toGuiSpace

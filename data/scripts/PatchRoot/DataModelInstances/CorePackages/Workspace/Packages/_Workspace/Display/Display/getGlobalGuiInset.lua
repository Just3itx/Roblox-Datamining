-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T06:00:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")

local function getGlobalGuiInset()
    local vector2, vector2_2 = GuiService:GetGuiInset()
    return {
        top = vector2.Y,
        left = vector2.X,
        bottom = vector2_2.Y,
        right = vector2_2.X
    }
end

return getGlobalGuiInset

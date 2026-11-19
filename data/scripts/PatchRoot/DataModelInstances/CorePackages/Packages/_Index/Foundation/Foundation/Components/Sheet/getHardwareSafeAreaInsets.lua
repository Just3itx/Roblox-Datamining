-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:50:38Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local GuiService = require(Foundation.Utility.Wrappers).Services.GuiService

local function getHardwareSafeAreaInsets()
    local insetArea = GuiService:GetInsetArea(Enum.ScreenInsets.DeviceSafeInsets)
    local insetArea2 = GuiService:GetInsetArea(Enum.ScreenInsets.None)

    return {
        left = insetArea.Min.X - insetArea2.Min.X,
        top = insetArea.Min.Y - insetArea2.Min.Y,
        right = insetArea2.Max.X - insetArea.Max.X,
        bottom = insetArea2.Max.Y - insetArea.Max.Y
    }
end

return getHardwareSafeAreaInsets

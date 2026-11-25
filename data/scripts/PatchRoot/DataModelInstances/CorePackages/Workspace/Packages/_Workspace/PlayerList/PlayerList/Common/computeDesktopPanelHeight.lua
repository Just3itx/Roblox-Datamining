-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T02:51:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local Constants = require(scriptParentParent.Common.Constants)

local function computeDesktopPanelHeight(num1: number, num2: number, num3: number): number
    return math.max(math.min(num2, num1 * Constants.DESKTOP_MAX_VIEWPORT_FRACTION), num3)
end

return computeDesktopPanelHeight

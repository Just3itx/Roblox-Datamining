-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T23:40:37Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParent = scriptParent.Parent

local React = require(scriptParentParent.React)

local ThemeBackgroundSlice = require(scriptParent.ThemeBackgroundSlice)
local useThemeBackground = require(scriptParent.useThemeBackground)

local function ThemeBackgroundHeaderSlot()
    local var1 = useThemeBackground()
    if not var1 then
        return nil
    end
    return React.createElement(ThemeBackgroundSlice, { image = var1.image, baseColor = var1.baseColor })
end

return ThemeBackgroundHeaderSlot

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:01:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local Foundation = require(scriptParentParent.Foundation)

local function themeFromBackgroundColor(color3: Color3)
    if 0.299 * color3.R + 0.587 * color3.G + 0.114 * color3.B >= 0.5 then
        return Foundation.Enums.ColorMode.Light
    end

    return Foundation.Enums.ColorMode.Dark
end

return themeFromBackgroundColor

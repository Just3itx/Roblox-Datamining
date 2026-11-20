-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T18:39:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent

local IconSize = require(scriptParent.Enum.IconSize)
local getIconSize = require(scriptParent.getIconSize)

return function(arg1): UDim2
    assert(IconSize.isEnumValue(arg1))
    local iconSize = getIconSize(arg1)
    return UDim2.fromOffset(iconSize, iconSize)
end

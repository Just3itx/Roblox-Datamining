-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:55Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent

local _StyleTypes = require(scriptParentParentParentParent.Style.StyleTypes)
local _Constants = require(scriptParent.Constants)
local _AspectRatioMode = require(scriptParent.Enum.AspectRatioMode)

local getExperienceTileRelativeHeight = require(scriptParent.getExperienceTileRelativeHeight)

return function(arg1, num1: number, arg2, num2: number?, num3: number?, arg3): number
    local experienceTileRelativeHeight = getExperienceTileRelativeHeight(arg1, arg2, num2, num3, arg3)

    return math.floor(num1 * experienceTileRelativeHeight.Scale + experienceTileRelativeHeight.Offset)
end

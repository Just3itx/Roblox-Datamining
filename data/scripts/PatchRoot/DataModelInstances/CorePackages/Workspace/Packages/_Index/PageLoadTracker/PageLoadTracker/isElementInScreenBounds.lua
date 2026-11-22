-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local PageLoadConfig = require(script.Parent.PageLoadConfig)

function isElementInScreenBounds(arg1, vector2: Vector2, num1: number): boolean
    local absolutePosition = arg1.AbsolutePosition
    local absoluteSize = arg1.AbsoluteSize

    if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
        return false
    end

    local absolutePositionX = absolutePosition.X
    local var1 = absolutePosition.X + absoluteSize.X

    local vector2X = vector2.X

    local num2 = math.max(absolutePositionX, 0)
    local num3 = math.max(0, math.min(var1, vector2X) - num2)

    local absolutePositionY = absolutePosition.Y
    local var2 = absolutePosition.Y + absoluteSize.Y

    local vector2Y = vector2.Y

    local num4 = math.max(absolutePositionY, num1)
    local num5 = math.max(0, math.min(var2, vector2Y) - num4)

    local bool1 = absoluteSize.X * PageLoadConfig.SCREEN_BOUNDS.MIN_VISIBILITY_RATIO <= num3
    local bool2 = absoluteSize.Y * PageLoadConfig.SCREEN_BOUNDS.MIN_VISIBILITY_RATIO <= num5

    return bool1 and bool2
end

return isElementInScreenBounds

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:10:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function isPointInGuiObjectBounds(arg1, vector2: Vector2): boolean
    if not arg1 then
        return false
    end
    local absolutePosition = arg1.AbsolutePosition
    local absoluteSize = arg1.AbsoluteSize
    local absolutePositionX = absolutePosition.X
    local absolutePositionY = absolutePosition.Y
    local var1 = absolutePosition.X + absoluteSize.X
    local var2 = absolutePosition.Y + absoluteSize.Y

    return absolutePositionX <= vector2.X and vector2.X <= var1 and absolutePositionY <= vector2.Y and vector2.Y <= var2
end

return isPointInGuiObjectBounds

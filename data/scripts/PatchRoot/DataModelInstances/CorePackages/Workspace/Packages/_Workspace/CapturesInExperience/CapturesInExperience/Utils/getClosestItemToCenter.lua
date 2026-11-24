-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T00:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getClosestItemToCenter(vector2: Vector2, arg1): (number, number)
    local absoluteSize = arg1.AbsoluteSize
    local canvasPosition = arg1.CanvasPosition

    local num1 = math.floor((canvasPosition.X + absoluteSize.X / 2) / vector2.X) + 1
    return num1, math.abs(canvasPosition.X - (num1 - 1) * vector2.X)
end

return getClosestItemToCenter

-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:21:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MessageGroupShape = require(script.Parent.MessageGroupShape)

local Direction = MessageGroupShape.Direction
local MessageGroupShapePosition = MessageGroupShape.Position

local function getGroupCornerRadii(arg1, num1: number)
    if arg1.position == MessageGroupShapePosition.Only then
        return { topLeft = num1, topRight = num1, bottomLeft = num1, bottomRight = num1 }
    end

    local num2 = if arg1.position ~= MessageGroupShapePosition.First then 0 else num1
    local num3 = if arg1.position ~= MessageGroupShapePosition.Last then 0 else num1

    return if arg1.direction == Direction.Incoming then {
        topLeft = num2,
        topRight = num1,
        bottomLeft = num3,
        bottomRight = num1
    } else { topLeft = num1, topRight = num2, bottomLeft = num1, bottomRight = num3 }
end

return getGroupCornerRadii

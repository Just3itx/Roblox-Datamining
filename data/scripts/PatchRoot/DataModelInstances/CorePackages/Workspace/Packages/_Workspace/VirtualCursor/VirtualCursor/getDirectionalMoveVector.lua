-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:21:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local function getDirectionForKeycode(keyCode, num1: number): Vector2
    if keyCode == Enum.KeyCode.ButtonUp then
        return Vector2.new(0, -num1)
    elseif keyCode == Enum.KeyCode.ButtonDown then
        return Vector2.new(0, num1)
    elseif keyCode == Enum.KeyCode.ButtonLeft then
        return Vector2.new(-num1, 0)
    elseif keyCode == Enum.KeyCode.ButtonRight then
        return Vector2.new(num1, 0)
    end
    return Vector2.zero
end

local function getDirectionalMoveVector(tbl1)
    local zero = Vector2.zero
    for value, value2 in tbl1 do
        zero += getDirectionForKeycode(value, value2)
    end

    if zero.Magnitude > 1 then
        zero = zero.Unit
    end

    return zero
end

return getDirectionalMoveVector

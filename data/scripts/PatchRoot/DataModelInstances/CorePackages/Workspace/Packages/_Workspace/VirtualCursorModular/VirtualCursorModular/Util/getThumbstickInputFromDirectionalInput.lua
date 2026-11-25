-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T21:31:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local _GuiService = game:GetService("GuiService")
local _Properties = require(scriptParentParent.Properties)

local function getThumbstickInputFromDirectionalInput(keyCode, num1: number)
    local zero = Vector2.zero
    if keyCode == Enum.KeyCode.ButtonUp then
        return Vector2.new(0, num1)
    end

    if keyCode == Enum.KeyCode.ButtonDown then
        return Vector2.new(0, -num1)
    end

    if keyCode == Enum.KeyCode.ButtonLeft then
        return Vector2.new(-num1, 0)
    end

    if keyCode == Enum.KeyCode.ButtonRight then
        zero = Vector2.new(num1, 0)
    end
    return zero
end

return getThumbstickInputFromDirectionalInput

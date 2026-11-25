-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local InputTypeConstants = require(scriptParentParent.InputType).InputTypeConstants
local getInputGroup = require(scriptParentParent.InputType).getInputGroup

local function isGamepadInput(arg1): boolean
    return getInputGroup(arg1) == InputTypeConstants.Gamepad
end

return isGamepadInput

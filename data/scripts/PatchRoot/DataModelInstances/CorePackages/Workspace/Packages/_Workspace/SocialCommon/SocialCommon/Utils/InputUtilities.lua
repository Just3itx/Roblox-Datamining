-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T15:21:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local module = {}

function module.isActivationInput(arg1): boolean
    return arg1.UserInputType == Enum.UserInputType.MouseButton1 or arg1.UserInputType == Enum.UserInputType.Touch
end

function module.isPointerInput(arg1): boolean
    return arg1.UserInputType == Enum.UserInputType.MouseMovement or arg1.UserInputType == Enum.UserInputType.Touch
end

function module.isTouchInput(arg1): boolean
    return arg1.UserInputType == Enum.UserInputType.Touch
end

return module

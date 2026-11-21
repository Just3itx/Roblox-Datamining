-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T05:30:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

return {
    isMouseWheel = function(arg1): boolean
        return arg1.UserInputType == Enum.UserInputType.MouseWheel
    end,
    isPrimaryPointerBegan = function(arg1): boolean
        return arg1.UserInputType == Enum.UserInputType.MouseButton1
    end,
    isPrimaryPointerEnded = function(arg1): boolean
        return arg1.UserInputType == Enum.UserInputType.MouseButton1
    end,
    isMouseMovement = function(arg1): boolean
        return arg1.UserInputType == Enum.UserInputType.MouseMovement
    end,
    isTouch = function(arg1): boolean
        return arg1.UserInputType == Enum.UserInputType.Touch
    end,
    isTouchEnabled = function(): boolean
        return UserInputService.TouchEnabled
    end
}

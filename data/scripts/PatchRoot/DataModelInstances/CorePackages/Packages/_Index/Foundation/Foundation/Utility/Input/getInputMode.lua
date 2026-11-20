-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T07:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local InputMode = require(Foundation.Utility.Input.InputMode)

local tbl1 = {
    [Enum.UserInputType.MouseButton1] = InputMode.Pointer,
    [Enum.UserInputType.MouseButton2] = InputMode.Pointer,
    [Enum.UserInputType.MouseButton3] = InputMode.Pointer,
    [Enum.UserInputType.MouseMovement] = InputMode.Pointer,
    [Enum.UserInputType.MouseWheel] = InputMode.Pointer,
    [Enum.UserInputType.None] = InputMode.Pointer,
    [Enum.UserInputType.TextInput] = InputMode.Pointer,
    [Enum.UserInputType.Gamepad1] = InputMode.Directional,
    [Enum.UserInputType.Gamepad2] = InputMode.Directional,
    [Enum.UserInputType.Gamepad3] = InputMode.Directional,
    [Enum.UserInputType.Gamepad4] = InputMode.Directional,
    [Enum.UserInputType.Gamepad5] = InputMode.Directional,
    [Enum.UserInputType.Gamepad6] = InputMode.Directional,
    [Enum.UserInputType.Gamepad7] = InputMode.Directional,
    [Enum.UserInputType.Gamepad8] = InputMode.Directional,
    [Enum.UserInputType.Keyboard] = InputMode.Directional,
    [Enum.UserInputType.Touch] = InputMode.Touch
}

local function getInputMode(arg1)
    return tbl1[arg1]
end

return getInputMode

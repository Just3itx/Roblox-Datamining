-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T22:31:11Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local InputTypeConstants = require(script.Parent.InputTypeConstants)

return {
    [Enum.UserInputType.MouseButton1] = InputTypeConstants.MouseAndKeyboard,
    [Enum.UserInputType.MouseButton2] = InputTypeConstants.MouseAndKeyboard,
    [Enum.UserInputType.MouseButton3] = InputTypeConstants.MouseAndKeyboard,
    [Enum.UserInputType.MouseWheel] = InputTypeConstants.MouseAndKeyboard,
    [Enum.UserInputType.MouseMovement] = InputTypeConstants.MouseAndKeyboard,
    [Enum.UserInputType.Keyboard] = InputTypeConstants.MouseAndKeyboard,
    [Enum.UserInputType.TextInput] = InputTypeConstants.MouseAndKeyboard,
    [Enum.UserInputType.Gamepad1] = InputTypeConstants.Gamepad,
    [Enum.UserInputType.Gamepad2] = InputTypeConstants.Gamepad,
    [Enum.UserInputType.Gamepad3] = InputTypeConstants.Gamepad,
    [Enum.UserInputType.Gamepad4] = InputTypeConstants.Gamepad,
    [Enum.UserInputType.Gamepad5] = InputTypeConstants.Gamepad,
    [Enum.UserInputType.Gamepad6] = InputTypeConstants.Gamepad,
    [Enum.UserInputType.Gamepad7] = InputTypeConstants.Gamepad,
    [Enum.UserInputType.Gamepad8] = InputTypeConstants.Gamepad,
    [Enum.UserInputType.Touch] = InputTypeConstants.Touch,
    [Enum.UserInputType.None] = InputTypeConstants.None
}

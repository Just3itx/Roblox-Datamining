-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T11:41:12Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    [Enum.UserInputType.MouseButton1] = "Mouse",
    [Enum.UserInputType.MouseButton2] = "Mouse",
    [Enum.UserInputType.MouseButton3] = "Mouse",
    [Enum.UserInputType.MouseWheel] = "Mouse",
    [Enum.UserInputType.MouseMovement] = "Mouse",
    [Enum.UserInputType.Touch] = "Touch",
    [Enum.UserInputType.Keyboard] = "Keyboard",
    [Enum.UserInputType.Focus] = nil,
    [Enum.UserInputType.Accelerometer] = nil,
    [Enum.UserInputType.Gyro] = nil,
    [Enum.UserInputType.Gamepad1] = "Gamepad",
    [Enum.UserInputType.Gamepad2] = "Gamepad",
    [Enum.UserInputType.Gamepad3] = "Gamepad",
    [Enum.UserInputType.Gamepad4] = "Gamepad",
    [Enum.UserInputType.Gamepad5] = "Gamepad",
    [Enum.UserInputType.Gamepad6] = "Gamepad",
    [Enum.UserInputType.Gamepad7] = "Gamepad",
    [Enum.UserInputType.Gamepad8] = "Gamepad",
    [Enum.UserInputType.TextInput] = nil,
    [Enum.UserInputType.InputMethod] = nil,
    [Enum.UserInputType.None] = nil
}

local function getInputMethod(arg1)
    return tbl1[arg1]
end

return getInputMethod

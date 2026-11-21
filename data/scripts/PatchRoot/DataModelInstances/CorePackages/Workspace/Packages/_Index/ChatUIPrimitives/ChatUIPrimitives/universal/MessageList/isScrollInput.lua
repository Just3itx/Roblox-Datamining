-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T07:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local tbl1 = {
    [Enum.UserInputType.MouseWheel] = true,
    [Enum.UserInputType.MouseButton1] = true,
    [Enum.UserInputType.Touch] = true
}

local tbl2 = {
    [Enum.UserInputType.Gamepad1] = true,
    [Enum.UserInputType.Gamepad2] = true,
    [Enum.UserInputType.Gamepad3] = true,
    [Enum.UserInputType.Gamepad4] = true,
    [Enum.UserInputType.Gamepad5] = true,
    [Enum.UserInputType.Gamepad6] = true,
    [Enum.UserInputType.Gamepad7] = true,
    [Enum.UserInputType.Gamepad8] = true
}

local tbl3 = {
    [Enum.KeyCode.Thumbstick1] = true,
    [Enum.KeyCode.Thumbstick2] = true
}

local function isScrollInput(arg1, bool1: boolean): boolean
    if tbl1[arg1.UserInputType] then
        return true
    end
    if not tbl2[arg1.UserInputType] then
        return false
    end
    if not bool1 then
        return true
    end
    return tbl3[arg1.KeyCode] == true and arg1.Position.Magnitude > 0.2
end

return isScrollInput

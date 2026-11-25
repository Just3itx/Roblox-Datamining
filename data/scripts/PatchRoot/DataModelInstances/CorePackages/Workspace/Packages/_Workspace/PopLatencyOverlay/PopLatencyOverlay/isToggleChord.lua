-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

return function(arg1, arg2)
    local var1 = arg2 or UserInputService
    if arg1.KeyCode ~= Enum.KeyCode.L then
        return false
    end
    local isKeyDown = var1:IsKeyDown(Enum.KeyCode.LeftShift) or var1:IsKeyDown(Enum.KeyCode.RightShift)
    local isKeyDown2 = var1:IsKeyDown(Enum.KeyCode.LeftMeta)
        or var1:IsKeyDown(Enum.KeyCode.RightMeta)
        or var1:IsKeyDown(Enum.KeyCode.LeftControl)
        or var1:IsKeyDown(Enum.KeyCode.RightControl)
    return isKeyDown and isKeyDown2
end

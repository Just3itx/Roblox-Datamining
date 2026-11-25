-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:31:32Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local function doesGamepadSupportKeyCodes(tbl1, arg1)
    for _, value in tbl1 do
        if not UserInputService:GamepadSupports(arg1, value) then
            return false
        end
    end
    return true
end

return doesGamepadSupportKeyCodes

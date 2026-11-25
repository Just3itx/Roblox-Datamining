-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T08:41:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local isGamepadInput = require(script.Parent.isGamepadInput)

local function wasLastInputGamepad()
    local userInputType = UserInputService:GetLastInputType()
    return isGamepadInput(userInputType)
end

return wasLastInputGamepad

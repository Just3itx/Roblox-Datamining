-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:01:40Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local function getChipDismissInput(): (boolean, boolean)
    return UserInputService.MouseEnabled, UserInputService.TouchEnabled
end

return getChipDismissInput

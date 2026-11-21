-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T22:21:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

local function getUserInputIsSelectionOnly(): boolean
    return not (UserInputService.TouchEnabled or UserInputService.MouseEnabled)
end

return getUserInputIsSelectionOnly

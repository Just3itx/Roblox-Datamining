-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")

return {
    getPlatform = function(): Enum.Platform
        return UserInputService:GetPlatform()
    end,
    statusReadTimeoutSeconds = 1
}

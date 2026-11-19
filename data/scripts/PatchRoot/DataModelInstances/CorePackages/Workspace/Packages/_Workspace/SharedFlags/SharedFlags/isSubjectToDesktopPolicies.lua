-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T04:11:21Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local platform = game:GetService("UserInputService"):GetPlatform()

return function(): boolean
    return platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.UWP
end

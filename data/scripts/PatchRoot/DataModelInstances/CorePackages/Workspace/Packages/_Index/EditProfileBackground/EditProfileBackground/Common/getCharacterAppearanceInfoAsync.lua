-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T12:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

return function(userId: number)
    return Players:GetCharacterAppearanceInfoAsync(userId)
end

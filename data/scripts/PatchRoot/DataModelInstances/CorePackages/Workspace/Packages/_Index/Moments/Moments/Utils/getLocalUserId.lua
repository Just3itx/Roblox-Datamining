-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T05:40:43Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

return function(): number?
    local localPlayer = Players.LocalPlayer
    return if localPlayer == nil then nil else localPlayer.UserId
end

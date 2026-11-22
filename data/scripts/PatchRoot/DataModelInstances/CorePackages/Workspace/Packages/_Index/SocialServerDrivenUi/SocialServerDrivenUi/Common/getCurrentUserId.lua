-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:05Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Players = game:GetService("Players")

local function getCurrentUserId()
    local localPlayer = Players.LocalPlayer
    if localPlayer == nil then
        return nil
    end
    return tostring(localPlayer.UserId)
end

return getCurrentUserId
